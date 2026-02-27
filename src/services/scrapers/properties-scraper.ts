import { BaseScraper, ScraperResult } from './base-scraper'

export interface ScrapedProperty {
  title: string
  category: 'House' | 'Apartment' | 'Land'
  listingType: 'sale' | 'rent'
  description: string
  price: number
  currency: string
  location: string
  areaSqm?: number
  bedrooms?: number
  bathrooms?: number
  imageUrls: string[]
  contactPhone?: string
  contactEmail?: string
  sourceUrl: string
}

/**
 * Scraper for House In Rwanda
 * URL: https://www.houseinrwanda.com
 * Uses Drupal with advert_teaser class for property cards
 */
class HouseInRwandaScraper extends BaseScraper<ScrapedProperty> {
  constructor() {
    super('HouseInRwanda', 'https://www.houseinrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedProperty>> {
    const properties: ScrapedProperty[] = []
    const errors: string[] = []

    // Scrape both sale and rent listings
    const pages = [
      { url: '/sale-adverts', listingType: 'sale' as const },
      { url: '/rent-adverts', listingType: 'rent' as const },
    ]

    for (const page of pages) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}${page.url}`)

        if (!$) {
          errors.push(`Failed to fetch ${this.baseUrl}${page.url}`)
          continue
        }

        // Property cards use advert_teaser class
        // Structure: .advert_teaser contains images, h5/h6 title in <a href="/property/...">
        $('.advert_teaser').each((_, element) => {
          try {
            const $el = $(element)

            // Get title from h5 or h6 within property link
            const titleEl = $el.find('a[href*="/property/"] h5, a[href*="/property/"] h6, h5 a, h6 a').first()
            let title = this.cleanText(titleEl.text())

            // Fallback: get any link to /property/
            if (!title || title.length < 5) {
              const propLink = $el.find('a[href*="/property/"]').first()
              title = this.cleanText(propLink.text())
            }
            if (!title || title.length < 5) return

            const link = $el.find('a[href*="/property/"]').first().attr('href')
            const sourceUrl = link?.startsWith('http') ? link : `${this.baseUrl}${link}`

            // Get price - format like "600,000 RWF/month" or "50,000,000 RWF"
            const priceText = $el.text()
            const { price, currency } = this.parseRwandaPrice(priceText)

            // Get location - City, District, Sector format
            const location = this.extractLocation($el.text())

            // Get images from flexslider or img tags
            const imageUrls: string[] = []
            $el.find('img').each((_, img) => {
              const src = $(img).attr('src') || $(img).attr('data-src')
              if (src && (src.startsWith('http') || src.startsWith('/'))) {
                const fullUrl = src.startsWith('http') ? src : `${this.baseUrl}${src}`
                if (!imageUrls.includes(fullUrl)) {
                  imageUrls.push(fullUrl)
                }
              }
            })

            // Extract bedrooms/bathrooms from text
            const bedrooms = this.extractNumber(priceText, /(\d+)\s*(?:bed|bedroom|br)/i)
            const bathrooms = this.extractNumber(priceText, /(\d+)\s*(?:bath|bathroom)/i)

            // Determine property category
            const category = this.inferCategory(title + ' ' + priceText)

            properties.push({
              title,
              category,
              listingType: page.listingType,
              description: title,
              price,
              currency,
              location,
              bedrooms,
              bathrooms,
              imageUrls: imageUrls.slice(0, 5), // Limit to 5 images
              sourceUrl,
            })
          } catch (e) {
            errors.push(`Error parsing property: ${e}`)
          }
        })
      } catch (error) {
        errors.push(`HouseInRwanda ${page.url} error: ${error}`)
      }
    }

    return { success: errors.length === 0, data: properties, errors, source: this.name }
  }

  private parseRwandaPrice(text: string): { price: number; currency: string } {
    // Look for RWF prices like "600,000 RWF" or "50,000,000 RWF"
    const rwfMatch = text.match(/([\d,]+)\s*(?:RWF|Rwf|rwf|FRW|Frw)/i)
    if (rwfMatch) {
      return {
        price: parseInt(rwfMatch[1].replace(/,/g, ''), 10),
        currency: 'RWF',
      }
    }

    // Look for USD prices
    const usdMatch = text.match(/\$\s*([\d,]+)|USD\s*([\d,]+)|([\d,]+)\s*USD/i)
    if (usdMatch) {
      const priceStr = usdMatch[1] || usdMatch[2] || usdMatch[3]
      return {
        price: parseInt(priceStr.replace(/,/g, ''), 10),
        currency: 'USD',
      }
    }

    // Generic number extraction
    const numMatch = text.match(/([\d,]+)/);
    if (numMatch) {
      return {
        price: parseInt(numMatch[1].replace(/,/g, ''), 10),
        currency: 'RWF',
      }
    }

    return { price: 0, currency: 'RWF' }
  }

  private extractLocation(text: string): string {
    // Common Kigali areas
    const areas = [
      'Kiyovu', 'Nyarutarama', 'Gacuriro', 'Kibagabaga', 'Kimihurura',
      'Kacyiru', 'Remera', 'Kanombe', 'Gikondo', 'Nyamirambo',
      'Kimironko', 'Kabeza', 'Kagugu', 'Rusororo', 'Masaka',
      'Gasabo', 'Kicukiro', 'Nyarugenge',
    ]

    for (const area of areas) {
      if (text.includes(area)) {
        return `${area}, Kigali, Rwanda`
      }
    }

    if (text.toLowerCase().includes('kigali')) {
      return 'Kigali, Rwanda'
    }

    return 'Rwanda'
  }

  private extractNumber(text: string, pattern: RegExp): number | undefined {
    const match = text.match(pattern)
    return match ? parseInt(match[1], 10) : undefined
  }

  private inferCategory(text: string): ScrapedProperty['category'] {
    const lower = text.toLowerCase()
    if (lower.includes('land') || lower.includes('plot') || lower.includes('terrain')) {
      return 'Land'
    }
    if (lower.includes('apartment') || lower.includes('flat') || lower.includes('studio')) {
      return 'Apartment'
    }
    return 'House'
  }
}

/**
 * Scraper for Rwanda Housing Authority listings
 * URL: https://rha.gov.rw
 */
class RHAScraper extends BaseScraper<ScrapedProperty> {
  constructor() {
    super('RHA', 'https://rha.gov.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedProperty>> {
    const properties: ScrapedProperty[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/index.php?id=affordable-houses`)

      if (!$) {
        errors.push('Failed to fetch RHA page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Look for housing project listings
      $('article, .housing-project, .card, .listing').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          if (!title) return

          const description = this.cleanText($el.find('p, .description').first().text())
          const link = $el.find('a').first().attr('href')

          // RHA usually shows affordable housing projects
          properties.push({
            title,
            category: 'House',
            listingType: 'sale',
            description: description || title,
            price: 0, // RHA prices vary
            currency: 'RWF',
            location: 'Kigali, Rwanda',
            imageUrls: [],
            sourceUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
          })
        } catch (e) {
          errors.push(`Error parsing RHA listing: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`RHA scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: properties, errors, source: this.name }
  }
}

/**
 * Combined properties scraper
 */
export async function scrapeAllProperties(): Promise<ScraperResult<ScrapedProperty>> {
  const allProperties: ScrapedProperty[] = []
  const allErrors: string[] = []

  const scrapers = [
    new HouseInRwandaScraper(),
    new RHAScraper(),
  ]

  for (const scraper of scrapers) {
    try {
      console.log(`Running ${scraper['name']} scraper...`)
      const result = await scraper.scrape()
      allProperties.push(...result.data)
      allErrors.push(...result.errors)
    } catch (error) {
      allErrors.push(`Scraper failed: ${error}`)
    }
  }

  // Remove duplicates by title
  const uniqueProperties = allProperties.filter(
    (prop, index, self) =>
      index === self.findIndex((p) => p.title.toLowerCase() === prop.title.toLowerCase())
  )

  console.log(`Scraped ${uniqueProperties.length} unique properties`)

  return {
    success: allErrors.length === 0,
    data: uniqueProperties,
    errors: allErrors,
    source: 'AllProperties',
  }
}

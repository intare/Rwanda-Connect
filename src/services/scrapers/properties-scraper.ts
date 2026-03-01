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

    // Scrape both sale and rent listings (updated URLs)
    const pages = [
      { url: '/for-sale', listingType: 'sale' as const },
      { url: '/for-rent', listingType: 'rent' as const },
    ]

    for (const page of pages) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}${page.url}`)

        if (!$) {
          errors.push(`Failed to fetch ${this.baseUrl}${page.url}`)
          continue
        }

        // Property listings: look for h3/h5 links to /property/
        // Site uses semantic HTML without dedicated card classes
        $('a[href*="/property/"]').each((_, element) => {
          try {
            const $link = $(element)
            const href = $link.attr('href')
            if (!href) return

            // Get title from heading inside link or link text
            const h5 = $link.find('h5, h3').first()
            let title = this.cleanText(h5.text() || $link.text())

            // Skip navigation/short links
            if (!title || title.length < 10) return
            if (title.toLowerCase().includes('previous') || title.toLowerCase().includes('next')) return

            const sourceUrl = href.startsWith('http') ? href : `${this.baseUrl}${href}`

            // Skip duplicates
            if (properties.some((p) => p.sourceUrl === sourceUrl)) return

            // Get parent container for context - go up multiple levels to find the card
            let $container = $link.parent()
            // Go up until we find a container with images or hit 6 levels
            for (let i = 0; i < 6; i++) {
              if ($container.find('img').length > 0) break
              $container = $container.parent()
            }
            const containerText = $container.text()

            // Get price - format like "600,000 RWF/month" or "50,000,000 RWF"
            const { price, currency } = this.parseRwandaPrice(containerText)

            // Get location - City, District, Sector format
            const location = this.extractLocation(containerText)

            // Get images from container - look for various image sources
            const imageUrls: string[] = []
            $container.find('img').each((_, img) => {
              const $img = $(img)
              // Try multiple attributes for image source
              const src = $img.attr('src') || $img.attr('data-src') || $img.attr('data-lazy-src')
              if (src) {
                // Skip tiny images (likely icons)
                const width = parseInt($img.attr('width') || '100', 10)
                if (width < 50) return

                // Build full URL
                let fullUrl = src
                if (src.startsWith('//')) {
                  fullUrl = 'https:' + src
                } else if (src.startsWith('/')) {
                  fullUrl = `${this.baseUrl}${src}`
                }

                // Skip duplicates and non-property images
                if (!imageUrls.includes(fullUrl) && !fullUrl.includes('logo') && !fullUrl.includes('icon')) {
                  imageUrls.push(fullUrl)
                }
              }
            })

            // Extract bedrooms/bathrooms from text
            const bedrooms = this.extractNumber(containerText, /(\d+)\s*(?:bed|bedroom|br)/i)
            const bathrooms = this.extractNumber(containerText, /(\d+)\s*(?:bath|bathroom)/i)

            // Determine property category from title or URL
            const category = this.inferCategory(title + ' ' + href)

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

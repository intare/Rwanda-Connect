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
 * Scraper for Rwanda real estate listings from Lamudi
 */
class LamudiRwandaScraper extends BaseScraper<ScrapedProperty> {
  constructor() {
    super('LamudiRwanda', 'https://www.lamudi.co.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedProperty>> {
    const properties: ScrapedProperty[] = []
    const errors: string[] = []

    try {
      // Scrape for sale listings
      const $sale = await this.fetchPage(`${this.baseUrl}/for-sale/`)

      if ($sale) {
        $sale('.ListingCell, .listing-item, .property-card, article').each((_, element) => {
          try {
            const prop = this.parseProperty($sale, element, 'sale')
            if (prop) properties.push(prop)
          } catch (e) {
            errors.push(`Error parsing sale property: ${e}`)
          }
        })
      }

      // Scrape for rent listings
      const $rent = await this.fetchPage(`${this.baseUrl}/for-rent/`)

      if ($rent) {
        $rent('.ListingCell, .listing-item, .property-card, article').each((_, element) => {
          try {
            const prop = this.parseProperty($rent, element, 'rent')
            if (prop) properties.push(prop)
          } catch (e) {
            errors.push(`Error parsing rent property: ${e}`)
          }
        })
      }
    } catch (error) {
      errors.push(`Lamudi scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: properties, errors, source: this.name }
  }

  private parseProperty(
    $: cheerio.CheerioAPI,
    element: cheerio.Element,
    listingType: 'sale' | 'rent'
  ): ScrapedProperty | null {
    const $el = $(element)

    const title = this.cleanText($el.find('h2, h3, .title, .listing-title').first().text())
    if (!title) return null

    const priceStr = this.cleanText($el.find('.price, .listing-price').first().text())
    const { price, currency } = this.parsePrice(priceStr)

    const location = this.cleanText($el.find('.location, .address').first().text())
    const description = this.cleanText($el.find('.description, p').first().text())

    // Parse features
    const bedroomsStr = this.cleanText($el.find('.bedrooms, .beds, [data-bedrooms]').first().text())
    const bathroomsStr = this.cleanText($el.find('.bathrooms, .baths, [data-bathrooms]').first().text())
    const areaStr = this.cleanText($el.find('.area, .size, [data-area]').first().text())

    const bedrooms = parseInt(bedroomsStr.match(/\d+/)?.[0] || '0', 10)
    const bathrooms = parseInt(bathroomsStr.match(/\d+/)?.[0] || '0', 10)
    const areaSqm = parseInt(areaStr.match(/\d+/)?.[0] || '0', 10)

    // Get images
    const imageUrls: string[] = []
    $el.find('img').each((_, img) => {
      const src = $(img).attr('src') || $(img).attr('data-src')
      if (src && src.startsWith('http')) {
        imageUrls.push(src)
      }
    })

    const link = $el.find('a').first().attr('href')

    return {
      title,
      category: this.inferCategory(title),
      listingType,
      description: description || title,
      price,
      currency,
      location: location || 'Kigali, Rwanda',
      areaSqm: areaSqm || undefined,
      bedrooms: bedrooms || undefined,
      bathrooms: bathrooms || undefined,
      imageUrls,
      sourceUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
    }
  }

  private inferCategory(title: string): ScrapedProperty['category'] {
    const lower = title.toLowerCase()
    if (lower.includes('land') || lower.includes('plot') || lower.includes('terrain')) {
      return 'Land'
    }
    if (lower.includes('apartment') || lower.includes('flat') || lower.includes('condo')) {
      return 'Apartment'
    }
    return 'House'
  }
}

/**
 * Scraper for HouseInRwanda listings
 */
class HouseInRwandaScraper extends BaseScraper<ScrapedProperty> {
  constructor() {
    super('HouseInRwanda', 'https://www.houseinrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedProperty>> {
    const properties: ScrapedProperty[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/properties`)

      if (!$) {
        errors.push('Failed to fetch HouseInRwanda page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.property-item, .listing, article, .card').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          if (!title) return

          const priceStr = this.cleanText($el.find('.price').first().text())
          const { price, currency } = this.parsePrice(priceStr)

          const location = this.cleanText($el.find('.location, .address').first().text())
          const description = this.cleanText($el.find('.description, p').first().text())
          const link = $el.find('a').first().attr('href')

          // Parse features
          const featuresText = $el.find('.features, .specs').text().toLowerCase()
          const bedroomMatch = featuresText.match(/(\d+)\s*bed/)
          const bathroomMatch = featuresText.match(/(\d+)\s*bath/)

          // Get images
          const imageUrls: string[] = []
          $el.find('img').each((_, img) => {
            const src = $(img).attr('src') || $(img).attr('data-src')
            if (src && src.startsWith('http')) {
              imageUrls.push(src)
            }
          })

          // Determine listing type
          const isRent = title.toLowerCase().includes('rent') || priceStr.toLowerCase().includes('/month')

          properties.push({
            title,
            category: this.inferCategory(title),
            listingType: isRent ? 'rent' : 'sale',
            description: description || title,
            price,
            currency,
            location: location || 'Kigali, Rwanda',
            bedrooms: bedroomMatch ? parseInt(bedroomMatch[1], 10) : undefined,
            bathrooms: bathroomMatch ? parseInt(bathroomMatch[1], 10) : undefined,
            imageUrls,
            sourceUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
          })
        } catch (e) {
          errors.push(`Error parsing property: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`HouseInRwanda scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: properties, errors, source: this.name }
  }

  private inferCategory(title: string): ScrapedProperty['category'] {
    const lower = title.toLowerCase()
    if (lower.includes('land') || lower.includes('plot')) return 'Land'
    if (lower.includes('apartment') || lower.includes('flat')) return 'Apartment'
    return 'House'
  }
}

/**
 * Scraper for RwandaHousing listings
 */
class RwandaHousingScraper extends BaseScraper<ScrapedProperty> {
  constructor() {
    super('RwandaHousing', 'https://rwandahousing.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedProperty>> {
    const properties: ScrapedProperty[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/listings`)

      if (!$) {
        errors.push('Failed to fetch RwandaHousing page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.property, .listing-item, article, .card').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          if (!title) return

          const priceStr = this.cleanText($el.find('.price').first().text())
          const { price, currency } = this.parsePrice(priceStr)

          const location = this.cleanText($el.find('.location').first().text())
          const description = this.cleanText($el.find('.description, p').first().text())
          const link = $el.find('a').first().attr('href')

          const imageUrls: string[] = []
          $el.find('img').each((_, img) => {
            const src = $(img).attr('src')
            if (src && src.startsWith('http')) {
              imageUrls.push(src)
            }
          })

          const isRent = title.toLowerCase().includes('rent')

          properties.push({
            title,
            category: this.inferCategory(title),
            listingType: isRent ? 'rent' : 'sale',
            description: description || title,
            price,
            currency,
            location: location || 'Kigali, Rwanda',
            imageUrls,
            sourceUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
          })
        } catch (e) {
          errors.push(`Error parsing property: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`RwandaHousing scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: properties, errors, source: this.name }
  }

  private inferCategory(title: string): ScrapedProperty['category'] {
    const lower = title.toLowerCase()
    if (lower.includes('land') || lower.includes('plot')) return 'Land'
    if (lower.includes('apartment') || lower.includes('flat')) return 'Apartment'
    return 'House'
  }
}

/**
 * Combined properties scraper
 */
export async function scrapeAllProperties(): Promise<ScraperResult<ScrapedProperty>> {
  const allProperties: ScrapedProperty[] = []
  const allErrors: string[] = []

  const scrapers = [
    new LamudiRwandaScraper(),
    new HouseInRwandaScraper(),
    new RwandaHousingScraper(),
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

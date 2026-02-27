import { BaseScraper, ScraperResult } from './base-scraper'

export interface ScrapedBusiness {
  name: string
  category:
    | 'Real Estate'
    | 'Hospitality'
    | 'Retail'
    | 'Professional Services'
    | 'Technology'
    | 'Finance'
    | 'Health'
    | 'Education'
    | 'Construction'
    | 'Agriculture'
    | 'Other'
  subcategory?: string
  description: string
  phone?: string
  email?: string
  website?: string
  address: string
  city: string
  district?: string
  social?: {
    facebook?: string
    instagram?: string
    linkedin?: string
    x?: string
  }
  services: string[]
  tags: string[]
  logoUrl?: string
  imageUrls: string[]
}

/**
 * Scraper for Rwanda Yellow Pages
 */
class RwandaYellowPagesScraper extends BaseScraper<ScrapedBusiness> {
  constructor() {
    super('RwandaYellowPages', 'https://www.yellowpages.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedBusiness>> {
    const businesses: ScrapedBusiness[] = []
    const errors: string[] = []

    const categories = [
      'hotels',
      'restaurants',
      'banks',
      'hospitals',
      'schools',
      'real-estate',
      'technology',
      'construction',
    ]

    for (const category of categories) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}/category/${category}`)

        if (!$) {
          errors.push(`Failed to fetch ${category} category`)
          continue
        }

        $('.business-item, .listing, .company-card, article').each((_, element) => {
          try {
            const $el = $(element)
            const name = this.cleanText($el.find('h2, h3, .company-name, .title').first().text())
            if (!name) return

            const description = this.cleanText($el.find('.description, p').first().text())
            const address = this.cleanText($el.find('.address, .location').first().text())
            const phone = this.cleanText($el.find('.phone, .tel, [href^="tel:"]').first().text())
            const email = this.cleanText($el.find('.email, [href^="mailto:"]').first().text())
            const website = $el.find('a[href^="http"]:not([href*="yellowpages"])').first().attr('href')

            const imageUrls: string[] = []
            $el.find('img').each((_, img) => {
              const src = $(img).attr('src')
              if (src && src.startsWith('http')) {
                imageUrls.push(src)
              }
            })

            businesses.push({
              name,
              category: this.mapCategory(category),
              description: description || name,
              phone: phone || undefined,
              email: email || undefined,
              website: website || undefined,
              address: address || 'Kigali',
              city: 'Kigali',
              services: [],
              tags: [category, 'rwanda'],
              imageUrls,
            })
          } catch (e) {
            errors.push(`Error parsing business: ${e}`)
          }
        })
      } catch (error) {
        errors.push(`Yellow Pages category ${category} error: ${error}`)
      }
    }

    return { success: errors.length === 0, data: businesses, errors, source: this.name }
  }

  private mapCategory(urlCategory: string): ScrapedBusiness['category'] {
    const mapping: Record<string, ScrapedBusiness['category']> = {
      hotels: 'Hospitality',
      restaurants: 'Hospitality',
      banks: 'Finance',
      hospitals: 'Health',
      schools: 'Education',
      'real-estate': 'Real Estate',
      technology: 'Technology',
      construction: 'Construction',
    }
    return mapping[urlCategory] || 'Other'
  }
}

/**
 * Scraper for Rwanda Business Directory
 */
class RwandaBusinessDirectoryScraper extends BaseScraper<ScrapedBusiness> {
  constructor() {
    super('RwandaBusinessDirectory', 'https://www.rwandabusiness.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedBusiness>> {
    const businesses: ScrapedBusiness[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/directory`)

      if (!$) {
        errors.push('Failed to fetch Rwanda Business Directory page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.business, .company, .listing, article').each((_, element) => {
        try {
          const $el = $(element)
          const name = this.cleanText($el.find('h2, h3, .name, .title').first().text())
          if (!name) return

          const description = this.cleanText($el.find('.description, p').first().text())
          const categoryText = this.cleanText($el.find('.category, .sector').first().text())
          const address = this.cleanText($el.find('.address, .location').first().text())
          const phone = this.cleanText($el.find('.phone, .contact').first().text())
          const email = $el.find('[href^="mailto:"]').first().attr('href')?.replace('mailto:', '')
          const website = $el.find('a[href^="http"]:not([href*="rwandabusiness"])').first().attr('href')

          const imageUrls: string[] = []
          $el.find('img').each((_, img) => {
            const src = $(img).attr('src')
            if (src && src.startsWith('http')) {
              imageUrls.push(src)
            }
          })

          businesses.push({
            name,
            category: this.inferCategory(categoryText || name),
            subcategory: categoryText || undefined,
            description: description || name,
            phone: phone || undefined,
            email: email || undefined,
            website: website || undefined,
            address: address || 'Kigali',
            city: 'Kigali',
            services: [],
            tags: ['rwanda', 'business'],
            imageUrls,
          })
        } catch (e) {
          errors.push(`Error parsing business: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Rwanda Business Directory scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: businesses, errors, source: this.name }
  }

  private inferCategory(text: string): ScrapedBusiness['category'] {
    const lower = text.toLowerCase()

    if (lower.includes('hotel') || lower.includes('restaurant') || lower.includes('hospitality')) {
      return 'Hospitality'
    }
    if (lower.includes('bank') || lower.includes('finance') || lower.includes('insurance')) {
      return 'Finance'
    }
    if (lower.includes('hospital') || lower.includes('clinic') || lower.includes('health')) {
      return 'Health'
    }
    if (lower.includes('school') || lower.includes('university') || lower.includes('education')) {
      return 'Education'
    }
    if (lower.includes('tech') || lower.includes('software') || lower.includes('it ')) {
      return 'Technology'
    }
    if (lower.includes('construction') || lower.includes('building')) {
      return 'Construction'
    }
    if (lower.includes('real estate') || lower.includes('property')) {
      return 'Real Estate'
    }
    if (lower.includes('retail') || lower.includes('shop') || lower.includes('store')) {
      return 'Retail'
    }
    if (lower.includes('farm') || lower.includes('agri')) {
      return 'Agriculture'
    }
    if (lower.includes('law') || lower.includes('consult') || lower.includes('service')) {
      return 'Professional Services'
    }

    return 'Other'
  }
}

/**
 * Scraper for Private Sector Federation Rwanda members
 */
class PSFRwandaScraper extends BaseScraper<ScrapedBusiness> {
  constructor() {
    super('PSFRwanda', 'https://www.psf.org.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedBusiness>> {
    const businesses: ScrapedBusiness[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/members`)

      if (!$) {
        errors.push('Failed to fetch PSF Rwanda members page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.member, .company, .listing, article, .card').each((_, element) => {
        try {
          const $el = $(element)
          const name = this.cleanText($el.find('h2, h3, .name, .title').first().text())
          if (!name) return

          const description = this.cleanText($el.find('.description, p').first().text())
          const sector = this.cleanText($el.find('.sector, .category').first().text())
          const address = this.cleanText($el.find('.address, .location').first().text())
          const phone = this.cleanText($el.find('.phone, .contact').first().text())
          const website = $el.find('a[href^="http"]:not([href*="psf.org"])').first().attr('href')

          const imageUrls: string[] = []
          const logo = $el.find('img').first().attr('src')
          if (logo && logo.startsWith('http')) {
            imageUrls.push(logo)
          }

          businesses.push({
            name,
            category: this.inferCategory(sector || name),
            subcategory: sector || undefined,
            description: description || `${name} - PSF Rwanda Member`,
            phone: phone || undefined,
            website: website || undefined,
            address: address || 'Kigali',
            city: 'Kigali',
            services: [],
            tags: ['rwanda', 'psf-member', 'verified'],
            logoUrl: logo,
            imageUrls,
          })
        } catch (e) {
          errors.push(`Error parsing PSF member: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`PSF Rwanda scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: businesses, errors, source: this.name }
  }

  private inferCategory(text: string): ScrapedBusiness['category'] {
    const lower = text.toLowerCase()

    if (lower.includes('hotel') || lower.includes('tourism') || lower.includes('hospitality')) {
      return 'Hospitality'
    }
    if (lower.includes('bank') || lower.includes('finance')) return 'Finance'
    if (lower.includes('health') || lower.includes('pharma')) return 'Health'
    if (lower.includes('education') || lower.includes('training')) return 'Education'
    if (lower.includes('tech') || lower.includes('ict')) return 'Technology'
    if (lower.includes('construction')) return 'Construction'
    if (lower.includes('agriculture') || lower.includes('agro')) return 'Agriculture'
    if (lower.includes('manufacturing') || lower.includes('industry')) return 'Other'

    return 'Professional Services'
  }
}

/**
 * Combined business directory scraper
 */
export async function scrapeAllBusinesses(): Promise<ScraperResult<ScrapedBusiness>> {
  const allBusinesses: ScrapedBusiness[] = []
  const allErrors: string[] = []

  const scrapers = [
    new RwandaYellowPagesScraper(),
    new RwandaBusinessDirectoryScraper(),
    new PSFRwandaScraper(),
  ]

  for (const scraper of scrapers) {
    try {
      console.log(`Running ${scraper['name']} scraper...`)
      const result = await scraper.scrape()
      allBusinesses.push(...result.data)
      allErrors.push(...result.errors)
    } catch (error) {
      allErrors.push(`Scraper failed: ${error}`)
    }
  }

  // Remove duplicates by name
  const uniqueBusinesses = allBusinesses.filter(
    (biz, index, self) =>
      index === self.findIndex((b) => b.name.toLowerCase() === biz.name.toLowerCase())
  )

  console.log(`Scraped ${uniqueBusinesses.length} unique businesses`)

  return {
    success: allErrors.length === 0,
    data: uniqueBusinesses,
    errors: allErrors,
    source: 'AllBusinesses',
  }
}

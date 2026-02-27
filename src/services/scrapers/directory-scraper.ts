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
 * Scraper for Rwanda YP (Yellow Pages)
 * URL: https://rwandayp.com
 * Uses /category/[Category_Name] for categories, /company/[ID]/[Name] for businesses
 */
class RwandaYellowPagesScraper extends BaseScraper<ScrapedBusiness> {
  constructor() {
    super('RwandaYellowPages', 'https://rwandayp.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedBusiness>> {
    const businesses: ScrapedBusiness[] = []
    const errors: string[] = []

    // Categories from rwandayp.com
    const categories = [
      { url: 'Restaurants', category: 'Hospitality' as const },
      { url: 'Hotels', category: 'Hospitality' as const },
      { url: 'Doctors_and_Clinics', category: 'Health' as const },
      { url: 'Estate_agents', category: 'Real Estate' as const },
      { url: 'Construction_services', category: 'Construction' as const },
      { url: 'Schools', category: 'Education' as const },
      { url: 'Banks', category: 'Finance' as const },
      { url: 'Lawyers', category: 'Professional Services' as const },
    ]

    for (const { url, category } of categories) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}/category/${url}`)

        if (!$) {
          errors.push(`Failed to fetch ${url} category`)
          continue
        }

        // Look for company links
        $('a[href*="/company/"]').each((_, element) => {
          try {
            const $el = $(element)
            const href = $el.attr('href')
            if (!href) return

            // Get company name from link text or nearby heading
            const name = this.cleanText($el.text())
            if (!name || name.length < 3 || name.length > 100) return

            // Skip navigation/generic links
            if (name.toLowerCase().includes('view') ||
                name.toLowerCase().includes('more') ||
                name.toLowerCase().includes('see all')) return

            // Get parent container for more details
            const $container = $el.closest('div, article, li')
            const description = this.cleanText($container.find('p, .description').first().text())
            const phone = this.cleanText($container.find('[href^="tel:"]').text())
            const address = this.cleanText($container.find('.address, .location').text())

            // Get image
            const imageUrl = $container.find('img').first().attr('src')
            const imageUrls: string[] = []
            if (imageUrl && imageUrl.startsWith('http')) {
              imageUrls.push(imageUrl)
            }

            // Avoid duplicates
            if (businesses.some((b) => b.name.toLowerCase() === name.toLowerCase())) return

            businesses.push({
              name,
              category,
              description: description || name,
              phone: phone || undefined,
              address: address || 'Kigali',
              city: 'Kigali',
              website: href.startsWith('http') ? href : `${this.baseUrl}${href}`,
              services: [],
              tags: [url.toLowerCase().replace('_', '-'), 'rwanda'],
              imageUrls,
            })
          } catch (e) {
            errors.push(`Error parsing business: ${e}`)
          }
        })
      } catch (error) {
        errors.push(`Rwanda YP category ${url} error: ${error}`)
      }
    }

    return { success: errors.length === 0, data: businesses, errors, source: this.name }
  }
}

/**
 * Scraper for Kigali location businesses from Rwanda YP
 * Scrapes by location instead of category for more coverage
 */
class KigaliBusinessScraper extends BaseScraper<ScrapedBusiness> {
  constructor() {
    super('KigaliBusinesses', 'https://rwandayp.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedBusiness>> {
    const businesses: ScrapedBusiness[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/location/Kigali`)

      if (!$) {
        errors.push('Failed to fetch Kigali businesses page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Look for company links
      $('a[href*="/company/"]').each((_, element) => {
        try {
          const $el = $(element)
          const href = $el.attr('href')
          if (!href) return

          const name = this.cleanText($el.text())
          if (!name || name.length < 3 || name.length > 100) return

          // Skip navigation links
          if (name.toLowerCase().includes('view') ||
              name.toLowerCase().includes('more') ||
              name.toLowerCase().includes('see all')) return

          const $container = $el.closest('div, article, li')
          const description = this.cleanText($container.find('p, .description').first().text())

          // Avoid duplicates
          if (businesses.some((b) => b.name.toLowerCase() === name.toLowerCase())) return

          businesses.push({
            name,
            category: this.inferCategory(name + ' ' + description),
            description: description || name,
            address: 'Kigali',
            city: 'Kigali',
            website: href.startsWith('http') ? href : `${this.baseUrl}${href}`,
            services: [],
            tags: ['rwanda', 'kigali'],
            imageUrls: [],
          })
        } catch (e) {
          errors.push(`Error parsing business: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Kigali businesses scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: businesses, errors, source: this.name }
  }

  private inferCategory(text: string): ScrapedBusiness['category'] {
    const lower = text.toLowerCase()

    if (lower.includes('hotel') || lower.includes('restaurant') || lower.includes('cafe') || lower.includes('bar')) {
      return 'Hospitality'
    }
    if (lower.includes('bank') || lower.includes('finance') || lower.includes('insurance') || lower.includes('microfinance')) {
      return 'Finance'
    }
    if (lower.includes('hospital') || lower.includes('clinic') || lower.includes('health') || lower.includes('pharma') || lower.includes('doctor')) {
      return 'Health'
    }
    if (lower.includes('school') || lower.includes('university') || lower.includes('college') || lower.includes('academy') || lower.includes('education')) {
      return 'Education'
    }
    if (lower.includes('tech') || lower.includes('software') || lower.includes('it ') || lower.includes('digital') || lower.includes('computer')) {
      return 'Technology'
    }
    if (lower.includes('construction') || lower.includes('building') || lower.includes('contractor')) {
      return 'Construction'
    }
    if (lower.includes('real estate') || lower.includes('property') || lower.includes('estate')) {
      return 'Real Estate'
    }
    if (lower.includes('retail') || lower.includes('shop') || lower.includes('store') || lower.includes('supermarket')) {
      return 'Retail'
    }
    if (lower.includes('farm') || lower.includes('agri') || lower.includes('coffee') || lower.includes('tea')) {
      return 'Agriculture'
    }
    if (lower.includes('law') || lower.includes('consult') || lower.includes('accounting') || lower.includes('audit')) {
      return 'Professional Services'
    }

    return 'Other'
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
    new KigaliBusinessScraper(),
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

import { BaseScraper, ScraperResult } from './base-scraper'

export interface ScrapedOpportunity {
  type: 'Job' | 'Investment' | 'Scholarship' | 'Tender'
  title: string
  company: string
  location: string
  description: string
  requirements: string[]
  salary?: number
  salaryCurrency: string
  deadline?: string
  applyUrl: string
  tags: string[]
}

/**
 * Scraper for Job In Rwanda (Drupal-based job portal)
 * URL: https://jobinrwanda.com
 */
class JobInRwandaScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('JobInRwanda', 'https://jobinrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    // Scrape different job categories
    const categories = ['', '/jobs', '/tenders', '/consultancy', '/internships']

    for (const category of categories) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}${category}`)

        if (!$) {
          errors.push(`Failed to fetch ${this.baseUrl}${category}`)
          continue
        }

        // Job listings have h5 titles within links to /job/
        // Structure: <a href="/job/slug"><h5>Title</h5></a> followed by <a href="/employer/slug">Company</a>
        $('a[href*="/job/"]').each((_, element) => {
          try {
            const $el = $(element)

            // Get job title from h5 inside the link, or the link text itself
            const h5Text = $el.find('h5').text()
            const title = this.cleanText(h5Text || $el.text())
            if (!title || title.length < 5) return

            // Skip navigation/menu links that aren't actual job listings
            if (title.toLowerCase() === 'jobs' || title.toLowerCase() === 'job') return

            const link = $el.attr('href')
            const applyUrl = link?.startsWith('http') ? link : `${this.baseUrl}${link}`

            // Find the parent container and look for employer link nearby
            const $container = $el.parent().parent()
            const employerLink = $container.find('a[href*="/employer/"]')
            const company = this.cleanText(employerLink.text()) || 'Unknown Company'

            // Get all text from container for location and deadline extraction
            const allText = $container.text()
            const location = this.extractLocation(allText) || 'Rwanda'

            // Extract deadline from text - formats like "27-02-2026" or "Deadline: 27-02-2026"
            const deadlineMatch = allText.match(/(\d{2}-\d{2}-\d{4})/)
            let deadline: string | undefined
            if (deadlineMatch) {
              const [day, month, year] = deadlineMatch[1].split('-')
              deadline = new Date(`${year}-${month}-${day}`).toISOString()
            }

            // Determine job type from text
            const jobType = this.inferJobType(allText, category)

            // Avoid duplicates
            if (opportunities.some((o) => o.title === title && o.company === company)) {
              return
            }

            opportunities.push({
              type: jobType,
              title,
              company,
              location,
              description: title,
              requirements: [],
              salaryCurrency: 'RWF',
              deadline,
              applyUrl,
              tags: ['job', 'rwanda', category.replace('/', '') || 'featured'],
            })
          } catch (e) {
            errors.push(`Error parsing job: ${e}`)
          }
        })
      } catch (error) {
        errors.push(`JobInRwanda category ${category} error: ${error}`)
      }
    }

    return { success: errors.length === 0, data: opportunities, errors, source: this.name }
  }

  private extractLocation(text: string): string {
    // Common Rwandan locations
    const locations = [
      'Kigali',
      'Gasabo',
      'Kicukiro',
      'Nyarugenge',
      'Huye',
      'Musanze',
      'Rubavu',
      'Rwamagana',
      'Muhanga',
      'Rusizi',
      'Nyagatare',
      'Bugesera',
      'Karongi',
      'Ngoma',
      'Kayonza',
    ]

    for (const loc of locations) {
      if (text.includes(loc)) {
        return `${loc}, Rwanda`
      }
    }
    return 'Rwanda'
  }

  private inferJobType(
    text: string,
    category: string
  ): ScrapedOpportunity['type'] {
    const lower = text.toLowerCase()
    if (category.includes('tender') || lower.includes('tender')) return 'Tender'
    if (category.includes('internship') || lower.includes('internship')) return 'Job'
    if (category.includes('consultancy') || lower.includes('consultancy')) return 'Job'
    return 'Job'
  }
}

/**
 * Scraper for BrighterMonday Rwanda
 * URL: https://www.brightermonday.co.rw
 */
class BrighterMondayScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('BrighterMonday', 'https://www.brightermonday.co.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/jobs`)

      if (!$) {
        errors.push('Failed to fetch BrighterMonday jobs page')
        return { success: false, data: [], errors, source: this.name }
      }

      // BrighterMonday uses article or div elements for job cards
      $('article, .job-card, .listing-card, [data-job-id]').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText(
            $el.find('h2, h3, .job-title, [class*="title"]').first().text()
          )
          if (!title) return

          const company = this.cleanText(
            $el.find('.company, .employer, [class*="company"]').first().text()
          )
          const location = this.cleanText(
            $el.find('.location, [class*="location"]').first().text()
          )
          const link = $el.find('a').first().attr('href')

          opportunities.push({
            type: 'Job',
            title,
            company: company || 'Unknown Company',
            location: location || 'Kigali, Rwanda',
            description: title,
            requirements: [],
            salaryCurrency: 'RWF',
            applyUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
            tags: ['job', 'rwanda', 'brightermonday'],
          })
        } catch (e) {
          errors.push(`Error parsing BrighterMonday job: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`BrighterMonday scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: opportunities, errors, source: this.name }
  }
}

/**
 * Combined opportunities scraper
 */
export async function scrapeAllOpportunities(): Promise<ScraperResult<ScrapedOpportunity>> {
  const allOpportunities: ScrapedOpportunity[] = []
  const allErrors: string[] = []

  const scrapers = [
    new JobInRwandaScraper(),
    new BrighterMondayScraper(),
  ]

  for (const scraper of scrapers) {
    try {
      console.log(`Running ${scraper['name']} scraper...`)
      const result = await scraper.scrape()
      allOpportunities.push(...result.data)
      allErrors.push(...result.errors)
    } catch (error) {
      allErrors.push(`Scraper failed: ${error}`)
    }
  }

  // Remove duplicates by title and company
  const uniqueOpportunities = allOpportunities.filter(
    (opp, index, self) =>
      index ===
      self.findIndex(
        (o) =>
          o.title.toLowerCase() === opp.title.toLowerCase() &&
          o.company.toLowerCase() === opp.company.toLowerCase()
      )
  )

  console.log(`Scraped ${uniqueOpportunities.length} unique opportunities`)

  return {
    success: allErrors.length === 0,
    data: uniqueOpportunities,
    errors: allErrors,
    source: 'AllOpportunities',
  }
}

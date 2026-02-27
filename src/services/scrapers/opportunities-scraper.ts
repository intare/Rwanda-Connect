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
 * Scraper for Job In Rwanda
 */
class JobInRwandaScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('JobInRwanda', 'https://www.jobinrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/jobs`)

      if (!$) {
        errors.push('Failed to fetch Job In Rwanda page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.job-listing, .job-item, .vacancy, article').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .job-title, .title').first().text())
          const company = this.cleanText($el.find('.company, .employer, .company-name').first().text())
          const location = this.cleanText($el.find('.location, .job-location').first().text())
          const description = this.cleanText($el.find('.description, .excerpt, p').first().text())
          const link = $el.find('a').first().attr('href')
          const deadlineStr = this.cleanText($el.find('.deadline, .closing-date').first().text())

          if (title && company) {
            opportunities.push({
              type: 'Job',
              title,
              company,
              location: location || 'Kigali, Rwanda',
              description: description || title,
              requirements: [],
              salaryCurrency: 'RWF',
              deadline: this.parseDate(deadlineStr)?.toISOString(),
              applyUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              tags: ['job', 'rwanda', 'employment'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing job: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`JobInRwanda scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: opportunities, errors, source: this.name }
  }
}

/**
 * Scraper for Rwanda Development Board opportunities
 */
class RDBOpportunitiesScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('RDBOpportunities', 'https://rdb.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/investment-opportunities`)

      if (!$) {
        errors.push('Failed to fetch RDB opportunities page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.opportunity-item, .investment-card, article, .card').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          const description = this.cleanText($el.find('.description, p, .excerpt').first().text())
          const link = $el.find('a').first().attr('href')
          const sector = this.cleanText($el.find('.sector, .category').first().text())

          if (title) {
            opportunities.push({
              type: 'Investment',
              title,
              company: 'Rwanda Development Board',
              location: 'Rwanda',
              description: description || title,
              requirements: [],
              salaryCurrency: 'USD',
              applyUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              tags: ['investment', 'rwanda', 'rdb', sector.toLowerCase()].filter(Boolean),
            })
          }
        } catch (e) {
          errors.push(`Error parsing RDB opportunity: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`RDB scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: opportunities, errors, source: this.name }
  }
}

/**
 * Scraper for Rwanda Public Procurement tenders
 */
class RPPAScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('RPPATenders', 'https://www.rppa.gov.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/tenders`)

      if (!$) {
        errors.push('Failed to fetch RPPA tenders page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.tender-item, .tender-listing, tr, .card').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .tender-title, td:first-child').first().text())
          const organization = this.cleanText($el.find('.organization, .entity, td:nth-child(2)').first().text())
          const deadlineStr = this.cleanText($el.find('.deadline, .closing-date, td:nth-child(3)').first().text())
          const link = $el.find('a').first().attr('href')

          if (title && title.length > 10) {
            opportunities.push({
              type: 'Tender',
              title,
              company: organization || 'Government of Rwanda',
              location: 'Rwanda',
              description: title,
              requirements: [],
              salaryCurrency: 'RWF',
              deadline: this.parseDate(deadlineStr)?.toISOString(),
              applyUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              tags: ['tender', 'rwanda', 'government', 'procurement'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing tender: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`RPPA scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: opportunities, errors, source: this.name }
  }
}

/**
 * Scraper for scholarships from MINEDUC
 */
class ScholarshipsScraper extends BaseScraper<ScrapedOpportunity> {
  constructor() {
    super('Scholarships', 'https://www.mineduc.gov.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedOpportunity>> {
    const opportunities: ScrapedOpportunity[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/scholarships`)

      if (!$) {
        errors.push('Failed to fetch MINEDUC scholarships page')
        return { success: false, data: [], errors, source: this.name }
      }

      $('.scholarship-item, article, .news-item, .card').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          const description = this.cleanText($el.find('.description, p, .excerpt').first().text())
          const link = $el.find('a').first().attr('href')
          const deadlineStr = this.cleanText($el.find('.deadline, .date').first().text())

          // Filter for scholarship-related content
          const isScholarship =
            title.toLowerCase().includes('scholarship') ||
            title.toLowerCase().includes('burse') || // Bursary
            title.toLowerCase().includes('fellowship') ||
            title.toLowerCase().includes('grant')

          if (title && isScholarship) {
            opportunities.push({
              type: 'Scholarship',
              title,
              company: 'MINEDUC Rwanda',
              location: 'Rwanda',
              description: description || title,
              requirements: [],
              salaryCurrency: 'USD',
              deadline: this.parseDate(deadlineStr)?.toISOString(),
              applyUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              tags: ['scholarship', 'education', 'rwanda'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing scholarship: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Scholarships scraper error: ${error}`)
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
    new RDBOpportunitiesScraper(),
    new RPPAScraper(),
    new ScholarshipsScraper(),
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

  // Remove duplicates by title
  const uniqueOpportunities = allOpportunities.filter(
    (opp, index, self) =>
      index === self.findIndex((o) => o.title.toLowerCase() === opp.title.toLowerCase())
  )

  console.log(`Scraped ${uniqueOpportunities.length} unique opportunities`)

  return {
    success: allErrors.length === 0,
    data: uniqueOpportunities,
    errors: allErrors,
    source: 'AllOpportunities',
  }
}

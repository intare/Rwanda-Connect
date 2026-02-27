import { BaseScraper, ScraperResult } from './base-scraper'

export interface ScrapedEvent {
  title: string
  description: string
  type: 'Networking' | 'Seminar' | 'Workshop' | 'Conference'
  organizer: string
  location: string
  venue?: string
  date: string
  endDate?: string
  imageUrl?: string
  registrationUrl?: string
  isVirtual: boolean
  tags: string[]
}

/**
 * Scraper for The New Times events
 */
class NewTimesEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('NewTimesEvents', 'https://www.newtimes.co.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    try {
      // Scrape events from New Times lifestyle/events section
      const $ = await this.fetchPage(`${this.baseUrl}/lifestyle`)

      if (!$) {
        errors.push('Failed to fetch New Times events page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Look for event-related articles
      $('article, .article-item, .story-item').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          const link = $el.find('a').first().attr('href')
          const imageUrl = $el.find('img').first().attr('src')
          const description = this.cleanText($el.find('p, .excerpt, .summary').first().text())

          // Only include if it looks like an event
          const isEvent =
            title.toLowerCase().includes('event') ||
            title.toLowerCase().includes('concert') ||
            title.toLowerCase().includes('festival') ||
            title.toLowerCase().includes('conference') ||
            title.toLowerCase().includes('workshop') ||
            title.toLowerCase().includes('seminar')

          if (title && isEvent) {
            events.push({
              title,
              description: description || title,
              type: this.inferEventType(title),
              organizer: 'The New Times',
              location: 'Kigali, Rwanda',
              date: new Date().toISOString(),
              imageUrl: imageUrl?.startsWith('http') ? imageUrl : `${this.baseUrl}${imageUrl}`,
              registrationUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              isVirtual: false,
              tags: ['rwanda', 'kigali'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing event: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`NewTimes scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: events, errors, source: this.name }
  }

  private inferEventType(title: string): ScrapedEvent['type'] {
    const lower = title.toLowerCase()
    if (lower.includes('conference')) return 'Conference'
    if (lower.includes('workshop')) return 'Workshop'
    if (lower.includes('seminar')) return 'Seminar'
    return 'Networking'
  }
}

/**
 * Scraper for Visit Rwanda events
 */
class VisitRwandaEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('VisitRwandaEvents', 'https://www.visitrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/events`)

      if (!$) {
        errors.push('Failed to fetch Visit Rwanda events page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Parse events from Visit Rwanda
      $('.event-item, .event-card, article').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .event-title, .title').first().text())
          const description = this.cleanText($el.find('.description, .excerpt, p').first().text())
          const dateStr = this.cleanText($el.find('.date, .event-date, time').first().text())
          const location = this.cleanText($el.find('.location, .venue').first().text())
          const imageUrl = $el.find('img').first().attr('src')
          const link = $el.find('a').first().attr('href')

          if (title) {
            events.push({
              title,
              description: description || title,
              type: this.inferEventType(title),
              organizer: 'Visit Rwanda',
              location: location || 'Rwanda',
              venue: location,
              date: this.parseDate(dateStr)?.toISOString() || new Date().toISOString(),
              imageUrl: imageUrl?.startsWith('http') ? imageUrl : `${this.baseUrl}${imageUrl}`,
              registrationUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              isVirtual: false,
              tags: ['rwanda', 'tourism', 'visit-rwanda'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing Visit Rwanda event: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Visit Rwanda scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: events, errors, source: this.name }
  }

  private inferEventType(title: string): ScrapedEvent['type'] {
    const lower = title.toLowerCase()
    if (lower.includes('conference')) return 'Conference'
    if (lower.includes('workshop')) return 'Workshop'
    if (lower.includes('seminar')) return 'Seminar'
    return 'Networking'
  }
}

/**
 * Scraper for Igihe events
 */
class IgiheEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('IgiheEvents', 'https://igihe.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/amakuru/ubukungu`)

      if (!$) {
        errors.push('Failed to fetch Igihe page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Look for event-related content
      $('article, .article, .news-item').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.find('h2, h3, .title').first().text())
          const link = $el.find('a').first().attr('href')
          const imageUrl = $el.find('img').first().attr('src')
          const description = this.cleanText($el.find('p, .excerpt').first().text())

          // Filter for events
          const isEvent =
            title.toLowerCase().includes('event') ||
            title.toLowerCase().includes('conference') ||
            title.toLowerCase().includes('inama') || // Meeting in Kinyarwanda
            title.toLowerCase().includes('umunsi') // Day/celebration

          if (title && isEvent) {
            events.push({
              title,
              description: description || title,
              type: 'Conference',
              organizer: 'Igihe',
              location: 'Kigali, Rwanda',
              date: new Date().toISOString(),
              imageUrl: imageUrl?.startsWith('http') ? imageUrl : `${this.baseUrl}${imageUrl}`,
              registrationUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
              isVirtual: false,
              tags: ['rwanda', 'igihe'],
            })
          }
        } catch (e) {
          errors.push(`Error parsing Igihe event: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Igihe scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: events, errors, source: this.name }
  }
}

/**
 * Combined events scraper
 */
export async function scrapeAllEvents(): Promise<ScraperResult<ScrapedEvent>> {
  const allEvents: ScrapedEvent[] = []
  const allErrors: string[] = []

  const scrapers = [
    new NewTimesEventsScraper(),
    new VisitRwandaEventsScraper(),
    new IgiheEventsScraper(),
  ]

  for (const scraper of scrapers) {
    try {
      console.log(`Running ${scraper['name']} scraper...`)
      const result = await scraper.scrape()
      allEvents.push(...result.data)
      allErrors.push(...result.errors)
    } catch (error) {
      allErrors.push(`Scraper failed: ${error}`)
    }
  }

  // Remove duplicates by title
  const uniqueEvents = allEvents.filter(
    (event, index, self) =>
      index === self.findIndex((e) => e.title.toLowerCase() === event.title.toLowerCase())
  )

  console.log(`Scraped ${uniqueEvents.length} unique events`)

  return {
    success: allErrors.length === 0,
    data: uniqueEvents,
    errors: allErrors,
    source: 'AllEvents',
  }
}

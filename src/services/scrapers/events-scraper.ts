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
 * Scrapes RSS feed for event-related content from entertainment/lifestyle
 */
class NewTimesEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('NewTimesEvents', 'https://www.newtimes.co.rw')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    try {
      // Use RSS feed since the website uses dynamic JS loading
      const response = await fetch(`${this.baseUrl}/rssFeed/33`) // Entertainment feed
      if (!response.ok) {
        errors.push('Failed to fetch New Times RSS feed')
        return { success: false, data: [], errors, source: this.name }
      }

      const xmlText = await response.text()

      // Parse RSS items manually since we're looking for event keywords
      const itemMatches = xmlText.matchAll(/<item>([\s\S]*?)<\/item>/g)

      for (const match of itemMatches) {
        try {
          const itemXml = match[1]

          // Extract title
          const titleMatch = itemXml.match(/<title><!\[CDATA\[(.*?)\]\]><\/title>/)
          const title = titleMatch ? titleMatch[1].trim() : ''
          if (!title) continue

          // Check if event-related
          const isEvent =
            title.toLowerCase().includes('event') ||
            title.toLowerCase().includes('concert') ||
            title.toLowerCase().includes('festival') ||
            title.toLowerCase().includes('conference') ||
            title.toLowerCase().includes('workshop') ||
            title.toLowerCase().includes('seminar') ||
            title.toLowerCase().includes('show') ||
            title.toLowerCase().includes('performance') ||
            title.toLowerCase().includes('exhibition') ||
            title.toLowerCase().includes('launch')

          if (!isEvent) continue

          // Extract other fields
          const linkMatch = itemXml.match(/<link>(.*?)<\/link>/)
          const link = linkMatch ? linkMatch[1].trim() : ''

          const descMatch = itemXml.match(/<description><!\[CDATA\[([\s\S]*?)\]\]><\/description>/)
          const description = descMatch ? descMatch[1].replace(/<[^>]+>/g, '').trim() : title

          const dateMatch = itemXml.match(/<pubDate>(.*?)<\/pubDate>/)
          const pubDate = dateMatch ? new Date(dateMatch[1]).toISOString() : new Date().toISOString()

          const imageMatch = itemXml.match(/<media:content[^>]*url="([^"]+)"/)
          const imageUrl = imageMatch ? imageMatch[1] : undefined

          events.push({
            title,
            description: description.slice(0, 500),
            type: this.inferEventType(title),
            organizer: 'The New Times',
            location: 'Kigali, Rwanda',
            date: pubDate,
            imageUrl,
            registrationUrl: link,
            isVirtual: false,
            tags: ['rwanda', 'kigali', 'entertainment'],
          })
        } catch (e) {
          errors.push(`Error parsing RSS item: ${e}`)
        }
      }
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
 * Scraper for Visit Rwanda - tourism activities as events
 * Visit Rwanda is primarily a tourism site, so we scrape activities/interests as events
 */
class VisitRwandaEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('VisitRwandaEvents', 'https://www.visitrwanda.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    // Scrape various activity pages
    const activityPages = [
      '/interests/gorilla-tracking/',
      '/interests/canopy-walkway/',
      '/tourism/',
    ]

    for (const page of activityPages) {
      try {
        const $ = await this.fetchPage(`${this.baseUrl}${page}`)

        if (!$) {
          errors.push(`Failed to fetch ${page}`)
          continue
        }

        // Visit Rwanda uses Elementor - look for content in various containers
        $('h2, h3').each((_, element) => {
          try {
            const $el = $(element)
            const title = this.cleanText($el.text())
            if (!title || title.length < 5 || title.length > 100) return

            // Get description from nearby paragraph
            const $parent = $el.closest('.e-con, .elementor-widget-container, section')
            const description = this.cleanText($parent.find('p').first().text())

            // Get image from nearby
            const imageUrl = $parent.find('img').first().attr('src')

            // Get link
            const link = $parent.find('a').first().attr('href')

            // Skip navigation items and generic text
            if (title.toLowerCase().includes('menu') ||
                title.toLowerCase().includes('navigation') ||
                title.toLowerCase().includes('footer')) return

            // Avoid duplicates
            if (events.some((e) => e.title === title)) return

            events.push({
              title,
              description: description || title,
              type: this.inferEventType(title),
              organizer: 'Visit Rwanda',
              location: 'Rwanda',
              date: new Date().toISOString(),
              imageUrl: imageUrl?.startsWith('http') ? imageUrl : imageUrl ? `${this.baseUrl}${imageUrl}` : undefined,
              registrationUrl: link?.startsWith('http') ? link : link ? `${this.baseUrl}${link}` : `${this.baseUrl}${page}`,
              isVirtual: false,
              tags: ['rwanda', 'tourism', 'visit-rwanda'],
            })
          } catch (e) {
            errors.push(`Error parsing Visit Rwanda content: ${e}`)
          }
        })
      } catch (error) {
        errors.push(`Visit Rwanda page ${page} error: ${error}`)
      }
    }

    return { success: errors.length === 0, data: events, errors, source: this.name }
  }

  private inferEventType(title: string): ScrapedEvent['type'] {
    const lower = title.toLowerCase()
    if (lower.includes('conference') || lower.includes('summit')) return 'Conference'
    if (lower.includes('workshop') || lower.includes('training')) return 'Workshop'
    if (lower.includes('seminar')) return 'Seminar'
    return 'Networking'
  }
}

/**
 * Scraper for Igihe events
 * Igihe uses flat list structure with links to /amakuru/[region]/article/[slug]
 */
class IgiheEventsScraper extends BaseScraper<ScrapedEvent> {
  constructor() {
    super('IgiheEvents', 'https://igihe.com')
  }

  async scrape(): Promise<ScraperResult<ScrapedEvent>> {
    const events: ScrapedEvent[] = []
    const errors: string[] = []

    try {
      const $ = await this.fetchPage(`${this.baseUrl}/amakuru`)

      if (!$) {
        errors.push('Failed to fetch Igihe page')
        return { success: false, data: [], errors, source: this.name }
      }

      // Igihe uses simple anchor links - look for article links
      $('a[href*="/article/"]').each((_, element) => {
        try {
          const $el = $(element)
          const title = this.cleanText($el.text())
          if (!title || title.length < 10) return

          const link = $el.attr('href')

          // Filter for event-related content in Kinyarwanda and English
          const lowerTitle = title.toLowerCase()
          const isEvent =
            lowerTitle.includes('event') ||
            lowerTitle.includes('conference') ||
            lowerTitle.includes('inama') || // Meeting
            lowerTitle.includes('umunsi') || // Day/celebration
            lowerTitle.includes('ibirori') || // Ceremony
            lowerTitle.includes('concert') ||
            lowerTitle.includes('festival') ||
            lowerTitle.includes('kwizihiza') || // Celebration
            lowerTitle.includes('show') ||
            lowerTitle.includes('imyidagaduro') // Entertainment

          if (!isEvent) return

          // Get image from nearby img tag
          const $parent = $el.parent()
          const imageUrl = $parent.find('img').attr('src') || $parent.prev().find('img').attr('src')

          // Skip duplicates
          if (events.some((e) => e.title === title)) return

          events.push({
            title,
            description: title,
            type: this.inferEventType(title),
            organizer: 'Igihe',
            location: 'Kigali, Rwanda',
            date: new Date().toISOString(),
            imageUrl: imageUrl?.startsWith('http') ? imageUrl : imageUrl ? `${this.baseUrl}${imageUrl}` : undefined,
            registrationUrl: link?.startsWith('http') ? link : `${this.baseUrl}${link}`,
            isVirtual: false,
            tags: ['rwanda', 'igihe'],
          })
        } catch (e) {
          errors.push(`Error parsing Igihe article: ${e}`)
        }
      })
    } catch (error) {
      errors.push(`Igihe scraper error: ${error}`)
    }

    return { success: errors.length === 0, data: events, errors, source: this.name }
  }

  private inferEventType(title: string): ScrapedEvent['type'] {
    const lower = title.toLowerCase()
    if (lower.includes('conference') || lower.includes('inama')) return 'Conference'
    if (lower.includes('workshop')) return 'Workshop'
    if (lower.includes('seminar')) return 'Seminar'
    return 'Networking'
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

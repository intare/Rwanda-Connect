import axios from 'axios'
import * as cheerio from 'cheerio'

export interface ScraperResult<T> {
  success: boolean
  data: T[]
  errors: string[]
  source: string
}

export abstract class BaseScraper<T> {
  protected name: string
  protected baseUrl: string

  constructor(name: string, baseUrl: string) {
    this.name = name
    this.baseUrl = baseUrl
  }

  protected async fetchPage(url: string): Promise<cheerio.CheerioAPI | null> {
    try {
      const response = await axios.get(url, {
        headers: {
          'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
          Accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
          'Accept-Language': 'en-US,en;q=0.5',
        },
        timeout: 30000,
      })
      return cheerio.load(response.data)
    } catch (error) {
      console.error(`[${this.name}] Failed to fetch ${url}:`, error)
      return null
    }
  }

  protected cleanText(text: string | undefined): string {
    if (!text) return ''
    return text.replace(/\s+/g, ' ').trim()
  }

  protected parsePrice(priceStr: string): { price: number; currency: string } {
    const cleaned = priceStr.replace(/[,\s]/g, '')

    // Check for currency indicators
    let currency = 'USD'
    if (cleaned.toLowerCase().includes('rwf') || cleaned.toLowerCase().includes('frw')) {
      currency = 'RWF'
    } else if (cleaned.includes('€')) {
      currency = 'EUR'
    } else if (cleaned.includes('£')) {
      currency = 'GBP'
    }

    // Extract number
    const match = cleaned.match(/[\d,]+/)
    const price = match ? parseInt(match[0].replace(/,/g, ''), 10) : 0

    return { price, currency }
  }

  protected parseDate(dateStr: string): Date | null {
    if (!dateStr) return null

    try {
      // Try various date formats
      const date = new Date(dateStr)
      if (!isNaN(date.getTime())) {
        return date
      }

      // Try parsing relative dates
      const lower = dateStr.toLowerCase()
      const now = new Date()

      if (lower.includes('today')) {
        return now
      }
      if (lower.includes('tomorrow')) {
        now.setDate(now.getDate() + 1)
        return now
      }
      if (lower.includes('next week')) {
        now.setDate(now.getDate() + 7)
        return now
      }

      return null
    } catch {
      return null
    }
  }

  abstract scrape(): Promise<ScraperResult<T>>
}

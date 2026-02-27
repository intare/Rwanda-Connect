import RssParser from 'rss-parser'

export interface RSSNewsItem {
  title: string
  summary: string
  content: string | null
  url: string
  publishDate: string
  category: 'Economy' | 'Investment' | 'Events' | 'Business' | 'Policy'
  imageUrl: string | null
  tags: string[]
}

interface CustomRSSItem {
  title?: string
  link?: string
  pubDate?: string
  content?: string
  contentSnippet?: string
  'content:encoded'?: string
  description?: string
  categories?: string[]
  guid?: string
}

interface CustomRSSFeed {
  title?: string
  description?: string
  items: CustomRSSItem[]
}

// The New Times RSS feeds
const RSS_FEEDS = [
  { url: 'https://www.newtimes.co.rw/rssFeed/14', category: 'News' },
  { url: 'https://www.newtimes.co.rw/rssFeed/17', category: 'Lifestyle' },
  { url: 'https://www.newtimes.co.rw/rssFeed/33', category: 'Entertainment' },
]

const parser = new RssParser<CustomRSSFeed, CustomRSSItem>({
  customFields: {
    item: [['content:encoded', 'content:encoded']],
  },
})

/**
 * Maps feed category to Payload News categories
 */
function mapCategory(feedCategory: string, urlPath: string): RSSNewsItem['category'] {
  const path = urlPath.toLowerCase()

  // Check URL path first for more specific categorization
  if (path.includes('economy') || path.includes('finance') || path.includes('money') || path.includes('business')) {
    return 'Economy'
  }
  if (path.includes('invest')) {
    return 'Investment'
  }
  if (path.includes('entertainment') || path.includes('sports') || path.includes('culture') || path.includes('lifestyle')) {
    return 'Events'
  }
  if (path.includes('politics') || path.includes('policy') || path.includes('government') || path.includes('law')) {
    return 'Policy'
  }

  // Fall back to feed category
  if (feedCategory === 'Entertainment' || feedCategory === 'Lifestyle') {
    return 'Events'
  }

  return 'Business'
}

/**
 * Strips HTML tags from a string
 */
function stripHtml(html: string | undefined | null): string {
  if (!html) return ''
  return html
    .replace(/<[^>]*>/g, '')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim()
}

/**
 * Extracts first image URL from HTML content
 */
function extractImageUrl(content: string | undefined | null): string | null {
  if (!content) return null

  const imgMatch = content.match(/<img[^>]+src="([^"]+)"/)
  if (imgMatch?.[1]) {
    return imgMatch[1]
  }

  return null
}

/**
 * Extracts category tag from URL path
 */
function extractTag(url: string): string {
  // URL format: /article/ID/category/subcategory/slug
  const parts = url.split('/')
  // Find the part after 'article/ID'
  if (parts.length >= 6) {
    return parts[5] || parts[4] || 'news'
  }
  return 'news'
}

/**
 * Fetches and parses a single RSS feed
 */
async function fetchSingleFeed(feedUrl: string, feedCategory: string): Promise<RSSNewsItem[]> {
  try {
    const feed = await parser.parseURL(feedUrl)

    return feed.items.map((item: CustomRSSItem) => {
      const content = item['content:encoded'] || item.content || null
      const summary = stripHtml(item.description || item.contentSnippet)
      const url = item.link || item.guid || ''

      return {
        title: item.title || 'Untitled',
        summary: summary.slice(0, 500),
        content: content ? stripHtml(content).slice(0, 2000) : null,
        url,
        publishDate: item.pubDate ? new Date(item.pubDate).toISOString() : new Date().toISOString(),
        category: mapCategory(feedCategory, url),
        imageUrl: extractImageUrl(content),
        tags: [extractTag(url)],
      }
    })
  } catch (error) {
    console.error(`Error fetching feed ${feedUrl}:`, error)
    return []
  }
}

/**
 * Fetches and combines news from all The New Times RSS feeds
 */
export async function fetchRSSFeed(): Promise<RSSNewsItem[]> {
  const feedPromises = RSS_FEEDS.map((feed) => fetchSingleFeed(feed.url, feed.category))
  const results = await Promise.all(feedPromises)

  // Combine all articles and sort by publish date (newest first)
  const allArticles = results.flat()
  allArticles.sort((a, b) => new Date(b.publishDate).getTime() - new Date(a.publishDate).getTime())

  // Remove duplicates by URL
  const seen = new Set<string>()
  return allArticles.filter((article) => {
    if (seen.has(article.url)) return false
    seen.add(article.url)
    return true
  })
}

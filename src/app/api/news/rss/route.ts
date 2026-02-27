import { NextResponse } from 'next/server'
import { fetchRSSFeed } from '../../../../services/rss-fetcher'

// In-memory cache to avoid hitting RSS feed on every request
let cachedNews: Awaited<ReturnType<typeof fetchRSSFeed>> | null = null
let cacheTimestamp = 0
const CACHE_DURATION_MS = 5 * 60 * 1000 // 5 minutes

export async function GET(request: Request) {
  try {
    const { searchParams } = new URL(request.url)
    const page = parseInt(searchParams.get('page') || '1', 10)
    const limit = parseInt(searchParams.get('limit') || '10', 10)
    const category = searchParams.get('category')

    // Check cache
    const now = Date.now()
    if (!cachedNews || now - cacheTimestamp > CACHE_DURATION_MS) {
      console.log('Fetching fresh RSS feed...')
      cachedNews = await fetchRSSFeed()
      cacheTimestamp = now
    }

    let articles = cachedNews

    // Filter by category if specified
    if (category) {
      articles = articles.filter((article) => article.category === category)
    }

    // Pagination
    const startIndex = (page - 1) * limit
    const endIndex = startIndex + limit
    const paginatedArticles = articles.slice(startIndex, endIndex)

    // Transform to match Payload News API format
    const docs = paginatedArticles.map((article, index) => ({
      id: `rss-${startIndex + index}`,
      title: article.title,
      category: article.category,
      summary: article.summary,
      url: article.url,
      publishDate: article.publishDate,
      isFeatured: index === 0, // First article is featured
      image: article.imageUrl
        ? {
            url: article.imageUrl,
            alt: article.title,
          }
        : null,
      tags: article.tags.map((tag) => ({ tag })),
      createdAt: article.publishDate,
      updatedAt: article.publishDate,
      source: article.source,
    }))

    return NextResponse.json({
      docs,
      totalDocs: articles.length,
      limit,
      page,
      totalPages: Math.ceil(articles.length / limit),
      hasNextPage: endIndex < articles.length,
      hasPrevPage: page > 1,
      nextPage: endIndex < articles.length ? page + 1 : null,
      prevPage: page > 1 ? page - 1 : null,
    })
  } catch (error) {
    console.error('RSS feed error:', error)

    return NextResponse.json(
      {
        error: error instanceof Error ? error.message : 'Failed to fetch RSS feed',
      },
      { status: 500 }
    )
  }
}

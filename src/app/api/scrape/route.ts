import { NextResponse } from 'next/server'
import { runAllScrapers } from '../../../services/scrapers'

export const dynamic = 'force-dynamic'
export const maxDuration = 300 // 5 minutes max for scraping

/**
 * POST /api/scrape
 * Triggers web scraping of Rwandan websites and imports data to Payload CMS
 *
 * Query params:
 * - type: 'all' | 'events' | 'opportunities' | 'properties' | 'businesses'
 *
 * Headers:
 * - x-api-key: Required for authentication (set in env as SCRAPER_API_KEY)
 */
export async function POST(request: Request) {
  try {
    // Check API key for authentication
    const apiKey = request.headers.get('x-api-key')
    const expectedKey = process.env.SCRAPER_API_KEY

    if (!expectedKey) {
      return NextResponse.json(
        { error: 'Scraper API key not configured' },
        { status: 500 }
      )
    }

    if (apiKey !== expectedKey) {
      return NextResponse.json(
        { error: 'Invalid API key' },
        { status: 401 }
      )
    }

    const { searchParams } = new URL(request.url)
    const type = searchParams.get('type') || 'all'

    console.log(`Starting scraper for type: ${type}`)

    let result

    if (type === 'all') {
      result = await runAllScrapers()
    } else {
      // Import specific scrapers
      const {
        scrapeAllEvents,
        scrapeAllOpportunities,
        scrapeAllProperties,
        scrapeAllBusinesses,
        importEvents,
        importOpportunities,
        importProperties,
        importBusinesses,
      } = await import('../../../services/scrapers')

      switch (type) {
        case 'events':
          const eventsData = await scrapeAllEvents()
          result = { events: await importEvents(eventsData.data) }
          break
        case 'opportunities':
          const oppsData = await scrapeAllOpportunities()
          result = { opportunities: await importOpportunities(oppsData.data) }
          break
        case 'properties':
          const propsData = await scrapeAllProperties()
          result = { properties: await importProperties(propsData.data) }
          break
        case 'businesses':
          const bizData = await scrapeAllBusinesses()
          result = { businesses: await importBusinesses(bizData.data) }
          break
        default:
          return NextResponse.json(
            { error: `Unknown scraper type: ${type}` },
            { status: 400 }
          )
      }
    }

    return NextResponse.json({
      success: true,
      message: 'Scraping completed',
      result,
    })
  } catch (error) {
    console.error('Scraping error:', error)
    return NextResponse.json(
      {
        error: error instanceof Error ? error.message : 'Scraping failed',
      },
      { status: 500 }
    )
  }
}

/**
 * GET /api/scrape
 * Returns scraper status and available types
 */
export async function GET() {
  return NextResponse.json({
    status: 'ready',
    availableTypes: ['all', 'events', 'opportunities', 'properties', 'businesses'],
    usage: 'POST /api/scrape?type=all with x-api-key header',
  })
}

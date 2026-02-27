/**
 * Command-line script to run web scrapers
 *
 * Usage:
 *   npx tsx src/run-scrapers.ts [type]
 *
 * Types:
 *   all         - Run all scrapers (default)
 *   events      - Scrape events only
 *   opportunities - Scrape opportunities only
 *   properties  - Scrape properties only
 *   businesses  - Scrape businesses only
 *   test        - Test scrapers without importing to CMS
 */

import 'dotenv/config'

import { scrapeAllEvents } from './services/scrapers/events-scraper'
import { scrapeAllOpportunities } from './services/scrapers/opportunities-scraper'
import { scrapeAllProperties } from './services/scrapers/properties-scraper'
import { scrapeAllBusinesses } from './services/scrapers/directory-scraper'

async function main() {
  const type = process.argv[2] || 'all'

  console.log('🕷️  Rwanda Connect Web Scraper')
  console.log('='.repeat(50))
  console.log(`Mode: ${type}`)
  console.log('='.repeat(50))

  try {
    if (type === 'test') {
      // Test mode - scrape without importing
      console.log('\n📅 Testing events scraper...')
      const events = await scrapeAllEvents()
      console.log(`Found ${events.data.length} events`)
      if (events.data.length > 0) {
        console.log('Sample:', JSON.stringify(events.data[0], null, 2))
      }
      if (events.errors.length > 0) {
        console.log('Errors:', events.errors.slice(0, 5))
      }

      console.log('\n💼 Testing opportunities scraper...')
      const opportunities = await scrapeAllOpportunities()
      console.log(`Found ${opportunities.data.length} opportunities`)
      if (opportunities.data.length > 0) {
        console.log('Sample:', JSON.stringify(opportunities.data[0], null, 2))
      }
      if (opportunities.errors.length > 0) {
        console.log('Errors:', opportunities.errors.slice(0, 5))
      }

      console.log('\n🏠 Testing properties scraper...')
      const properties = await scrapeAllProperties()
      console.log(`Found ${properties.data.length} properties`)
      if (properties.data.length > 0) {
        console.log('Sample:', JSON.stringify(properties.data[0], null, 2))
      }
      if (properties.errors.length > 0) {
        console.log('Errors:', properties.errors.slice(0, 5))
      }

      console.log('\n🏢 Testing businesses scraper...')
      const businesses = await scrapeAllBusinesses()
      console.log(`Found ${businesses.data.length} businesses`)
      if (businesses.data.length > 0) {
        console.log('Sample:', JSON.stringify(businesses.data[0], null, 2))
      }
      if (businesses.errors.length > 0) {
        console.log('Errors:', businesses.errors.slice(0, 5))
      }

      console.log('\n✅ Test complete!')
      return
    }

    // For import modes, dynamically import the functions that need Payload
    const {
      runAllScrapers,
      importEvents,
      importOpportunities,
      importProperties,
      importBusinesses,
    } = await import('./services/scrapers')

    if (type === 'all') {
      const result = await runAllScrapers()

      console.log('\n📊 Summary:')
      console.log(`Events: ${result.events.imported} imported, ${result.events.skipped} skipped`)
      console.log(`Opportunities: ${result.opportunities.imported} imported, ${result.opportunities.skipped} skipped`)
      console.log(`Properties: ${result.properties.imported} imported, ${result.properties.skipped} skipped`)
      console.log(`Businesses: ${result.businesses.imported} imported, ${result.businesses.skipped} skipped`)
      return
    }

    // Individual scrapers
    switch (type) {
      case 'events': {
        console.log('\n📅 Scraping events...')
        const eventsData = await scrapeAllEvents()
        console.log(`Found ${eventsData.data.length} events`)
        const eventsResult = await importEvents(eventsData.data)
        console.log(`Imported: ${eventsResult.imported}, Skipped: ${eventsResult.skipped}`)
        break
      }

      case 'opportunities': {
        console.log('\n💼 Scraping opportunities...')
        const oppsData = await scrapeAllOpportunities()
        console.log(`Found ${oppsData.data.length} opportunities`)
        const oppsResult = await importOpportunities(oppsData.data)
        console.log(`Imported: ${oppsResult.imported}, Skipped: ${oppsResult.skipped}`)
        break
      }

      case 'properties': {
        console.log('\n🏠 Scraping properties...')
        const propsData = await scrapeAllProperties()
        console.log(`Found ${propsData.data.length} properties`)
        const propsResult = await importProperties(propsData.data)
        console.log(`Imported: ${propsResult.imported}, Skipped: ${propsResult.skipped}`)
        break
      }

      case 'businesses': {
        console.log('\n🏢 Scraping businesses...')
        const bizData = await scrapeAllBusinesses()
        console.log(`Found ${bizData.data.length} businesses`)
        const bizResult = await importBusinesses(bizData.data)
        console.log(`Imported: ${bizResult.imported}, Skipped: ${bizResult.skipped}`)
        break
      }

      default:
        console.error(`Unknown type: ${type}`)
        console.log('Available types: all, events, opportunities, properties, businesses, test')
        process.exit(1)
    }

    console.log('\n✅ Done!')
  } catch (error) {
    console.error('❌ Error:', error)
    process.exit(1)
  }
}

main()

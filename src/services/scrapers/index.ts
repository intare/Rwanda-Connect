import { getPayload } from 'payload'
import config from '@payload-config'
import { scrapeAllEvents, ScrapedEvent } from './events-scraper'
import { scrapeAllOpportunities, ScrapedOpportunity } from './opportunities-scraper'
import { scrapeAllProperties, ScrapedProperty } from './properties-scraper'
import { scrapeAllBusinesses, ScrapedBusiness } from './directory-scraper'

interface ImportResult {
  success: boolean
  imported: number
  skipped: number
  errors: string[]
}

/**
 * Import scraped events to Payload CMS
 */
async function importEvents(events: ScrapedEvent[]): Promise<ImportResult> {
  const payload = await getPayload({ config })
  let imported = 0
  let skipped = 0
  const errors: string[] = []

  for (const event of events) {
    try {
      // Check if event already exists by title
      const existing = await payload.find({
        collection: 'events',
        where: {
          title: { equals: event.title },
        },
        limit: 1,
      })

      if (existing.docs.length > 0) {
        skipped++
        continue
      }

      await payload.create({
        collection: 'events',
        data: {
          title: event.title,
          description: event.description,
          type: event.type,
          organizer: event.organizer,
          location: event.location,
          venue: event.venue,
          date: event.date,
          endDate: event.endDate,
          registrationUrl: event.registrationUrl,
          isVirtual: event.isVirtual,
          tags: event.tags.map((tag) => ({ tag })),
          isFeatured: false,
        },
      })

      imported++
    } catch (error) {
      errors.push(`Failed to import event "${event.title}": ${error}`)
    }
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

/**
 * Import scraped opportunities to Payload CMS
 */
async function importOpportunities(opportunities: ScrapedOpportunity[]): Promise<ImportResult> {
  const payload = await getPayload({ config })
  let imported = 0
  let skipped = 0
  const errors: string[] = []

  for (const opp of opportunities) {
    try {
      // Check if opportunity already exists by title and company
      const existing = await payload.find({
        collection: 'opportunities',
        where: {
          and: [{ title: { equals: opp.title } }, { company: { equals: opp.company } }],
        },
        limit: 1,
      })

      if (existing.docs.length > 0) {
        skipped++
        continue
      }

      await payload.create({
        collection: 'opportunities',
        data: {
          type: opp.type,
          title: opp.title,
          company: opp.company,
          location: opp.location,
          description: opp.description,
          requirements: opp.requirements.map((req) => ({ requirement: req })),
          salary: opp.salary,
          salaryCurrency: opp.salaryCurrency,
          deadline: opp.deadline,
          applyUrl: opp.applyUrl,
          verified: false,
          isFeatured: false,
        },
      })

      imported++
    } catch (error) {
      errors.push(`Failed to import opportunity "${opp.title}": ${error}`)
    }
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

/**
 * Import scraped properties to Payload CMS
 */
async function importProperties(properties: ScrapedProperty[]): Promise<ImportResult> {
  const payload = await getPayload({ config })
  let imported = 0
  let skipped = 0
  const errors: string[] = []

  for (const prop of properties) {
    try {
      // Check if property already exists by title
      const existing = await payload.find({
        collection: 'real-estate',
        where: {
          title: { equals: prop.title },
        },
        limit: 1,
      })

      if (existing.docs.length > 0) {
        skipped++
        continue
      }

      await payload.create({
        collection: 'real-estate',
        data: {
          title: prop.title,
          category: prop.category,
          listingType: prop.listingType,
          description: prop.description,
          price: prop.price,
          currency: prop.currency,
          location: prop.location,
          areaSqm: prop.areaSqm,
          bedrooms: prop.bedrooms,
          bathrooms: prop.bathrooms,
          contactPhone: prop.contactPhone,
          contactEmail: prop.contactEmail,
          isFeatured: false,
          isAvailable: true,
        },
      })

      imported++
    } catch (error) {
      errors.push(`Failed to import property "${prop.title}": ${error}`)
    }
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

/**
 * Import scraped businesses to Payload CMS
 */
async function importBusinesses(businesses: ScrapedBusiness[]): Promise<ImportResult> {
  const payload = await getPayload({ config })
  let imported = 0
  let skipped = 0
  const errors: string[] = []

  for (const biz of businesses) {
    try {
      // Generate slug from name
      const slug = biz.name
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-|-$/g, '')

      // Check if business already exists by slug
      const existing = await payload.find({
        collection: 'business-directory',
        where: {
          slug: { equals: slug },
        },
        limit: 1,
      })

      if (existing.docs.length > 0) {
        skipped++
        continue
      }

      await payload.create({
        collection: 'business-directory',
        data: {
          name: biz.name,
          slug,
          category: biz.category,
          subcategory: biz.subcategory,
          description: biz.description,
          phone: biz.phone || 'N/A',
          email: biz.email,
          website: biz.website,
          address: biz.address,
          city: biz.city,
          district: biz.district,
          country: 'Rwanda',
          social: biz.social,
          services: biz.services.map((s) => ({ service: s })),
          tags: biz.tags.map((t) => ({ tag: t })),
          status: 'approved',
          isFeatured: false,
          isActive: true,
        },
      })

      imported++
    } catch (error) {
      errors.push(`Failed to import business "${biz.name}": ${error}`)
    }
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

/**
 * Run all scrapers and import data to Payload CMS
 */
export async function runAllScrapers(): Promise<{
  events: ImportResult
  opportunities: ImportResult
  properties: ImportResult
  businesses: ImportResult
}> {
  console.log('Starting web scraping...')
  console.log('=' .repeat(50))

  // Scrape events
  console.log('\n📅 Scraping events...')
  const eventsResult = await scrapeAllEvents()
  console.log(`Found ${eventsResult.data.length} events`)
  const eventsImport = await importEvents(eventsResult.data)
  console.log(`Imported: ${eventsImport.imported}, Skipped: ${eventsImport.skipped}`)

  // Scrape opportunities
  console.log('\n💼 Scraping opportunities...')
  const oppsResult = await scrapeAllOpportunities()
  console.log(`Found ${oppsResult.data.length} opportunities`)
  const oppsImport = await importOpportunities(oppsResult.data)
  console.log(`Imported: ${oppsImport.imported}, Skipped: ${oppsImport.skipped}`)

  // Scrape properties
  console.log('\n🏠 Scraping properties...')
  const propsResult = await scrapeAllProperties()
  console.log(`Found ${propsResult.data.length} properties`)
  const propsImport = await importProperties(propsResult.data)
  console.log(`Imported: ${propsImport.imported}, Skipped: ${propsImport.skipped}`)

  // Scrape businesses
  console.log('\n🏢 Scraping businesses...')
  const bizResult = await scrapeAllBusinesses()
  console.log(`Found ${bizResult.data.length} businesses`)
  const bizImport = await importBusinesses(bizResult.data)
  console.log(`Imported: ${bizImport.imported}, Skipped: ${bizImport.skipped}`)

  console.log('\n' + '='.repeat(50))
  console.log('Scraping complete!')

  return {
    events: eventsImport,
    opportunities: oppsImport,
    properties: propsImport,
    businesses: bizImport,
  }
}

// Export individual functions for selective scraping
export {
  scrapeAllEvents,
  scrapeAllOpportunities,
  scrapeAllProperties,
  scrapeAllBusinesses,
  importEvents,
  importOpportunities,
  importProperties,
  importBusinesses,
}

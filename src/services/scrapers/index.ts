import { getPayload, Payload } from 'payload'
import config from '@payload-config'
import axios from 'axios'
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
 * Download an image from URL and upload to Payload Media collection
 * Returns the media document ID or null if failed
 */
async function downloadAndUploadImage(
  payload: Payload,
  imageUrl: string,
  altText: string
): Promise<number | null> {
  try {
    // Skip invalid URLs
    if (!imageUrl || !imageUrl.startsWith('http')) {
      return null
    }

    // Download the image
    const response = await axios.get(imageUrl, {
      responseType: 'arraybuffer',
      timeout: 30000,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
    })

    // Get content type and determine extension
    const contentType = response.headers['content-type'] || 'image/jpeg'
    const ext = contentType.includes('png') ? 'png' : contentType.includes('webp') ? 'webp' : 'jpg'

    // Create a filename from the alt text
    const filename = `${altText.toLowerCase().replace(/[^a-z0-9]+/g, '-').slice(0, 50)}-${Date.now()}.${ext}`

    // Create a File-like object for Payload
    const buffer = Buffer.from(response.data)
    const file = {
      data: buffer,
      mimetype: contentType,
      name: filename,
      size: buffer.length,
    }

    // Upload to Payload Media collection
    const media = await payload.create({
      collection: 'media',
      data: {
        alt: altText,
      },
      file,
    })

    console.log(`  Uploaded image: ${filename}`)
    return media.id
  } catch (error) {
    console.error(`  Failed to download/upload image from ${imageUrl}:`, error instanceof Error ? error.message : error)
    return null
  }
}

// Map event type to lowercase values expected by Payload
const eventTypeMap: Record<string, string> = {
  'Networking': 'networking',
  'Seminar': 'seminar',
  'Workshop': 'workshop',
  'Conference': 'conference',
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

      // Map type to lowercase value
      const eventType = (eventTypeMap[event.type] || 'networking') as 'networking' | 'seminar' | 'workshop' | 'conference'

      await payload.create({
        collection: 'events',
        data: {
          title: event.title,
          description: event.description,
          type: eventType,
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
      console.error(`Error importing event "${event.title}":`, error)
    }
  }

  if (errors.length > 0) {
    console.log(`\nEvent import errors (showing first 5):`)
    errors.slice(0, 5).forEach((e) => console.log(`  - ${e}`))
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

// Map opportunity type to lowercase values expected by Payload
const opportunityTypeMap: Record<string, string> = {
  'Job': 'job',
  'Investment': 'investment',
  'Scholarship': 'scholarship',
  'Tender': 'tender',
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

      // Map type to lowercase value
      const oppType = (opportunityTypeMap[opp.type] || 'job') as 'job' | 'investment' | 'scholarship' | 'tender'

      await payload.create({
        collection: 'opportunities',
        data: {
          type: oppType,
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
      console.error(`Error importing opportunity "${opp.title}":`, error)
    }
  }

  if (errors.length > 0) {
    console.log(`\nOpportunity import errors (showing first 5):`)
    errors.slice(0, 5).forEach((e) => console.log(`  - ${e}`))
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

// Map property category to lowercase values expected by Payload
const propertyCategoryMap: Record<string, string> = {
  'House': 'house',
  'Apartment': 'apartment',
  'Land': 'land',
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

      // Map category to lowercase value
      const category = (propertyCategoryMap[prop.category] || 'house') as 'house' | 'apartment' | 'land'

      // Download and upload images (limit to first 3 images)
      const imageIds: number[] = []
      const imagesToProcess = prop.imageUrls.slice(0, 3)

      for (const imageUrl of imagesToProcess) {
        const mediaId = await downloadAndUploadImage(payload, imageUrl, prop.title)
        if (mediaId) {
          imageIds.push(mediaId)
        }
      }

      await payload.create({
        collection: 'real-estate',
        data: {
          title: prop.title,
          category,
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
          images: imageIds.length > 0 ? imageIds : undefined,
          isFeatured: false,
          isAvailable: true,
        },
      })

      imported++
      console.log(`  Imported: ${prop.title} (${imageIds.length} images)`)
    } catch (error) {
      errors.push(`Failed to import property "${prop.title}": ${error}`)
      console.error(`Error importing property "${prop.title}":`, error)
    }
  }

  if (errors.length > 0) {
    console.log(`\nProperty import errors (showing first 5):`)
    errors.slice(0, 5).forEach((e) => console.log(`  - ${e}`))
  }

  return { success: errors.length === 0, imported, skipped, errors }
}

// Map scraper category names to Payload collection values
const categoryMap: Record<string, string> = {
  'Real Estate': 'real_estate',
  'Hospitality': 'hospitality',
  'Retail': 'retail',
  'Professional Services': 'professional_services',
  'Technology': 'technology',
  'Finance': 'finance',
  'Health': 'health',
  'Education': 'education',
  'Construction': 'construction',
  'Agriculture': 'agriculture',
  'Other': 'other',
}

/**
 * Import scraped businesses to Payload CMS
 */
async function importBusinesses(businesses: ScrapedBusiness[]): Promise<ImportResult> {
  const payload = await getPayload({ config })
  let imported = 0
  let skipped = 0
  const errors: string[] = []

  // Find or create a system user for scraped content
  const systemUser = await payload.find({
    collection: 'users',
    where: { email: { equals: 'scraper@rwandaconnect.com' } },
    limit: 1,
  })

  let ownerId: number
  if (systemUser.docs.length === 0) {
    // Create a system user for scraped content
    try {
      const newUser = await payload.create({
        collection: 'users',
        data: {
          email: 'scraper@rwandaconnect.com',
          password: 'scraper-system-' + Date.now(),
          role: 'admin',
        },
      })
      ownerId = newUser.id
      console.log('Created system user for scraped content')
    } catch (_e) {
      // User might exist, try to find admin user instead
      const adminUser = await payload.find({
        collection: 'users',
        where: { role: { equals: 'admin' } },
        limit: 1,
      })
      if (adminUser.docs.length > 0) {
        ownerId = adminUser.docs[0].id
      } else {
        errors.push('No admin user found to assign as owner')
        return { success: false, imported: 0, skipped: 0, errors }
      }
    }
  } else {
    ownerId = systemUser.docs[0].id
  }

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

      // Map category to valid value
      const category = (categoryMap[biz.category] || 'other') as 'real_estate' | 'hospitality' | 'retail' | 'professional_services' | 'technology' | 'finance' | 'health' | 'education' | 'construction' | 'agriculture' | 'other'

      await payload.create({
        collection: 'business-directory',
        data: {
          owner: ownerId,
          name: biz.name,
          slug,
          category,
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
      console.error(`Error importing "${biz.name}":`, error)
    }
  }

  if (errors.length > 0) {
    console.log(`\nBusiness import errors (showing first 5):`)
    errors.slice(0, 5).forEach((e) => console.log(`  - ${e}`))
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

/**
 * Script to delete all properties from the database
 * Run with: npx tsx src/delete-properties.ts
 */

import 'dotenv/config'
import { getPayload } from 'payload'
import config from '@payload-config'

async function deleteAllProperties() {
  console.log('Connecting to Payload...')
  const payload = await getPayload({ config })

  console.log('Fetching all properties...')
  const properties = await payload.find({
    collection: 'real-estate',
    limit: 1000,
  })

  console.log(`Found ${properties.docs.length} properties to delete`)

  for (const prop of properties.docs) {
    try {
      await payload.delete({
        collection: 'real-estate',
        id: prop.id,
      })
      console.log(`Deleted: ${prop.title}`)
    } catch (error) {
      console.error(`Failed to delete ${prop.title}:`, error)
    }
  }

  console.log('Done!')
  process.exit(0)
}

deleteAllProperties()

import 'dotenv/config'
import { getPayload } from 'payload'
import config from './payload.config'

/**
 * Script to clear all news articles from the database.
 * Run with: npx tsx src/clear-news.ts
 */
const clearNews = async () => {
  const payload = await getPayload({ config })

  console.log('Clearing all news articles...')

  // Get all news articles
  const news = await payload.find({
    collection: 'news',
    limit: 1000,
  })

  console.log(`Found ${news.docs.length} news articles to delete`)

  // Delete each news article
  for (const article of news.docs) {
    await payload.delete({
      collection: 'news',
      id: article.id,
    })
    console.log(`Deleted: ${article.title}`)
  }

  console.log('\nAll news articles have been deleted!')
  console.log('The app will now fetch fresh news from The New Times RSS feeds.')

  process.exit(0)
}

clearNews().catch((error) => {
  console.error('Failed to clear news:', error)
  process.exit(1)
})

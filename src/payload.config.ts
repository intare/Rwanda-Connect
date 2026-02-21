import { postgresAdapter } from '@payloadcms/db-postgres'
import { lexicalEditor } from '@payloadcms/richtext-lexical'
import path from 'path'
import { buildConfig } from 'payload'
import { fileURLToPath } from 'url'
import sharp from 'sharp'

import { Users } from './collections/Users'
import { Media } from './collections/Media'
import { News } from './collections/News'
import { Opportunities } from './collections/Opportunities'
import { Events } from './collections/Events'
import { CommunityPosts } from './collections/CommunityPosts'
import { Profiles } from './collections/Profiles'
import { Subscriptions } from './collections/Subscriptions'
import { Bookmarks } from './collections/Bookmarks'
import { EventRsvps } from './collections/EventRsvps'
import { RealEstate } from './collections/RealEstate'
import { BusinessDirectory } from './collections/BusinessDirectory'

const filename = fileURLToPath(import.meta.url)
const dirname = path.dirname(filename)

const requiredEnv = (key: 'PAYLOAD_SECRET' | 'DATABASE_URL'): string => {
  const value = process.env[key]
  if (!value) {
    throw new Error(`Missing required environment variable: ${key}`)
  }
  return value
}

const corsOrigins = (process.env.CORS_ORIGINS ?? 'http://localhost:3000')
  .split(',')
  .map((value) => value.trim())
  .filter(Boolean)

export default buildConfig({
  cookiePrefix: 'rwandaconnect',
  admin: {
    user: Users.slug,
    importMap: {
      baseDir: path.resolve(dirname),
    },
  },
  cors: corsOrigins,
  csrf: corsOrigins,
  // Email handled by Firebase Authentication
  collections: [
    Users,
    Media,
    News,
    Opportunities,
    Events,
    CommunityPosts,
    Profiles,
    Subscriptions,
    Bookmarks,
    EventRsvps,
    RealEstate,
    BusinessDirectory,
  ],
  editor: lexicalEditor(),
  secret: requiredEnv('PAYLOAD_SECRET'),
  typescript: {
    outputFile: path.resolve(dirname, 'payload-types.ts'),
  },
  db: postgresAdapter({
    pool: {
      connectionString: requiredEnv('DATABASE_URL'),
    },
  }),
  sharp,
  plugins: [],
})

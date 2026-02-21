import { postgresAdapter } from '@payloadcms/db-postgres'
import { nodemailerAdapter } from '@payloadcms/email-nodemailer'
import { lexicalEditor } from '@payloadcms/richtext-lexical'
import path from 'path'
import { buildConfig } from 'payload'
import { fileURLToPath } from 'url'
import sharp from 'sharp'
import nodemailer from 'nodemailer'

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

// SendGrid email transport (only if API key is configured)
const sendGridTransport = process.env.SENDGRID_API_KEY
  ? nodemailer.createTransport({
      host: 'smtp.sendgrid.net',
      port: 587,
      auth: {
        user: 'apikey',
        pass: process.env.SENDGRID_API_KEY,
      },
    })
  : undefined

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
  // Email disabled during testing - re-enable when SendGrid credits are available
  ...(sendGridTransport && {
    email: nodemailerAdapter({
      transport: sendGridTransport,
      defaultFromAddress: process.env.EMAIL_FROM_ADDRESS || 'noreply@rwandaconnect.com',
      defaultFromName: process.env.EMAIL_FROM_NAME || 'Rwanda Connect',
    }),
  }),
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

import { postgresAdapter } from '@payloadcms/db-postgres'
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

const filename = fileURLToPath(import.meta.url)
const dirname = path.dirname(filename)

// SendGrid email transport
const sendGridTransport = nodemailer.createTransport({
  host: 'smtp.sendgrid.net',
  port: 587,
  auth: {
    user: 'apikey',
    pass: process.env.SENDGRID_API_KEY,
  },
})

export default buildConfig({
  admin: {
    user: Users.slug,
    importMap: {
      baseDir: path.resolve(dirname),
    },
  },
  cors: '*',
  csrf: [
    'http://localhost:3000',
    'http://127.0.0.1:3000',
    'http://localhost',
    'http://127.0.0.1',
  ],
  email: {
    transport: sendGridTransport,
    fromAddress: process.env.EMAIL_FROM_ADDRESS || 'noreply@rwandaconnect.com',
    fromName: process.env.EMAIL_FROM_NAME || 'Rwanda Connect',
  },
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
  ],
  editor: lexicalEditor(),
  secret: process.env.PAYLOAD_SECRET || '',
  typescript: {
    outputFile: path.resolve(dirname, 'payload-types.ts'),
  },
  db: postgresAdapter({
    pool: {
      connectionString: process.env.DATABASE_URL || '',
    },
  }),
  sharp,
  plugins: [],
})

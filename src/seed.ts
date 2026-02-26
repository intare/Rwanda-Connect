import 'dotenv/config'
import { getPayload, Payload } from 'payload'
import config from './payload.config'
import fs from 'fs'
import path from 'path'

type NewsCategory = 'Economy' | 'Investment' | 'Events' | 'Business' | 'Policy'
type OpportunityType = 'job' | 'investment' | 'scholarship' | 'tender'
type EventType = 'networking' | 'seminar' | 'workshop' | 'conference'
type RealEstateCategory = 'house' | 'apartment' | 'land'
type RealEstateListingType = 'sale' | 'rent'
type BusinessDirectoryCategory =
  | 'real_estate'
  | 'hospitality'
  | 'retail'
  | 'professional_services'
  | 'technology'
  | 'health'

// Sample image URLs from Lorem Picsum (free, reliable image service)
const sampleImages = {
  news: [
    { url: 'https://picsum.photos/seed/rw-news-1/800/600', alt: 'Rwanda economy growth' },
    { url: 'https://picsum.photos/seed/rw-news-2/800/600', alt: 'Rwanda investment' },
    { url: 'https://picsum.photos/seed/rw-news-3/800/600', alt: 'Rwanda business' },
    { url: 'https://picsum.photos/seed/rw-news-4/800/600', alt: 'Kigali skyline' },
    { url: 'https://picsum.photos/seed/rw-news-5/800/600', alt: 'Rwanda technology' },
    { url: 'https://picsum.photos/seed/rw-news-6/800/600', alt: 'Rwanda agriculture' },
    { url: 'https://picsum.photos/seed/rw-news-7/800/600', alt: 'Rwanda conference' },
    { url: 'https://picsum.photos/seed/rw-news-8/800/600', alt: 'Rwanda event' },
    { url: 'https://picsum.photos/seed/rw-news-9/800/600', alt: 'Rwanda banking' },
    { url: 'https://picsum.photos/seed/rw-news-10/800/600', alt: 'Rwanda mobile payments' },
    { url: 'https://picsum.photos/seed/rw-news-11/800/600', alt: 'Rwanda healthcare' },
    { url: 'https://picsum.photos/seed/rw-news-12/800/600', alt: 'Rwanda policy' },
    { url: 'https://picsum.photos/seed/rw-news-13/800/600', alt: 'Rwanda real estate' },
    { url: 'https://picsum.photos/seed/rw-news-14/800/600', alt: 'Rwanda citizenship' },
    { url: 'https://picsum.photos/seed/rw-news-15/800/600', alt: 'Rwanda diaspora' },
  ],
  events: [
    { url: 'https://picsum.photos/seed/rw-event-1/800/600', alt: 'Networking event' },
    { url: 'https://picsum.photos/seed/rw-event-2/800/600', alt: 'Professional mixer' },
    { url: 'https://picsum.photos/seed/rw-event-3/800/600', alt: 'Tech meetup' },
    { url: 'https://picsum.photos/seed/rw-event-4/800/600', alt: 'Women in business' },
    { url: 'https://picsum.photos/seed/rw-event-5/800/600', alt: 'Real estate webinar' },
    { url: 'https://picsum.photos/seed/rw-event-6/800/600', alt: 'Tax seminar' },
    { url: 'https://picsum.photos/seed/rw-event-7/800/600', alt: 'Business registration' },
    { url: 'https://picsum.photos/seed/rw-event-8/800/600', alt: 'Investment workshop' },
    { url: 'https://picsum.photos/seed/rw-event-9/800/600', alt: 'Tech bootcamp' },
    { url: 'https://picsum.photos/seed/rw-event-10/800/600', alt: 'Grant writing' },
    { url: 'https://picsum.photos/seed/rw-event-11/800/600', alt: 'Tech summit' },
    { url: 'https://picsum.photos/seed/rw-event-12/800/600', alt: 'Diaspora convention' },
    { url: 'https://picsum.photos/seed/rw-event-13/800/600', alt: 'Investment forum' },
    { url: 'https://picsum.photos/seed/rw-event-14/800/600', alt: 'Healthcare summit' },
    { url: 'https://picsum.photos/seed/rw-event-15/800/600', alt: 'Rwanda Day celebration' },
  ],
  businesses: [
    { url: 'https://picsum.photos/seed/rw-biz-1/400/400', alt: 'Kigali Prime Properties logo' },
    { url: 'https://picsum.photos/seed/rw-biz-2/400/400', alt: 'Inzora Hospitality logo' },
    { url: 'https://picsum.photos/seed/rw-biz-3/400/400', alt: 'Kimironko Retail Hub logo' },
    { url: 'https://picsum.photos/seed/rw-biz-4/400/400', alt: 'Kigali Legal Advisory logo' },
    { url: 'https://picsum.photos/seed/rw-biz-5/400/400', alt: 'Norrsken Kigali logo' },
    { url: 'https://picsum.photos/seed/rw-biz-6/400/400', alt: 'Kigali Family Health logo' },
  ],
  realEstate: [
    { url: 'https://picsum.photos/seed/rw-re-1/800/600', alt: 'Modern house Nyarutarama' },
    { url: 'https://picsum.photos/seed/rw-re-2/800/600', alt: 'Apartment Kiyovu' },
    { url: 'https://picsum.photos/seed/rw-re-3/800/600', alt: 'Land plot Rebero' },
    { url: 'https://picsum.photos/seed/rw-re-4/800/600', alt: 'Family house Kibagabaga' },
    { url: 'https://picsum.photos/seed/rw-re-5/800/600', alt: 'Penthouse Kimihurura' },
    { url: 'https://picsum.photos/seed/rw-re-6/800/600', alt: 'Commercial land Kicukiro' },
    { url: 'https://picsum.photos/seed/rw-re-7/800/600', alt: 'Executive apartment Gacuriro' },
    { url: 'https://picsum.photos/seed/rw-re-8/800/600', alt: 'Villa Rusororo' },
  ],
  opportunities: [
    { url: 'https://picsum.photos/seed/rw-opp-1/400/400', alt: 'PayRwanda logo' },
    { url: 'https://picsum.photos/seed/rw-opp-2/400/400', alt: 'Irembo logo' },
    { url: 'https://picsum.photos/seed/rw-opp-3/400/400', alt: 'Bank of Kigali logo' },
    { url: 'https://picsum.photos/seed/rw-opp-4/400/400', alt: 'Visit Rwanda logo' },
    { url: 'https://picsum.photos/seed/rw-opp-5/400/400', alt: 'Andela logo' },
    { url: 'https://picsum.photos/seed/rw-opp-6/400/400', alt: 'King Faisal Hospital logo' },
    { url: 'https://picsum.photos/seed/rw-opp-7/400/400', alt: 'AC Group logo' },
    { url: 'https://picsum.photos/seed/rw-opp-8/400/400', alt: 'AgriTech Hub logo' },
    { url: 'https://picsum.photos/seed/rw-opp-9/400/400', alt: 'Prime Real Estate logo' },
    { url: 'https://picsum.photos/seed/rw-opp-10/400/400', alt: 'Green Energy logo' },
  ],
}

// Helper function to download and upload an image to Payload
async function uploadImageFromUrl(
  payload: Payload,
  imageUrl: string,
  altText: string,
  filename: string
): Promise<number | null> {
  try {
    console.log(`  Downloading: ${filename}...`)
    const response = await fetch(imageUrl, {
      headers: {
        'User-Agent': 'RwandaConnect-Seed/1.0',
      },
    })

    if (!response.ok) {
      console.warn(`  Failed to download ${filename}: ${response.status}`)
      return null
    }

    const arrayBuffer = await response.arrayBuffer()
    const buffer = Buffer.from(arrayBuffer)

    // Ensure media directory exists
    const mediaDir = path.resolve(process.cwd(), 'media')
    if (!fs.existsSync(mediaDir)) {
      fs.mkdirSync(mediaDir, { recursive: true })
    }

    // Save temporarily to disk (Payload requires file path for upload)
    const tempPath = path.join(mediaDir, `temp-${filename}`)
    fs.writeFileSync(tempPath, buffer)

    // Upload to Payload (bypass access control for seeding)
    const media = await payload.create({
      collection: 'media',
      data: {
        alt: altText,
      },
      filePath: tempPath,
      overrideAccess: true,
    })

    // Clean up temp file (Payload copies it)
    try {
      fs.unlinkSync(tempPath)
    } catch {
      // Ignore cleanup errors
    }

    console.log(`  Uploaded: ${filename} (ID: ${media.id})`)
    return media.id as number
  } catch (error) {
    console.warn(`  Error uploading ${filename}:`, error)
    return null
  }
}

// Cache for uploaded media IDs
const mediaCache: Record<string, number> = {}

async function getOrUploadImage(
  payload: Payload,
  category: keyof typeof sampleImages,
  index: number
): Promise<number | null> {
  const cacheKey = `${category}-${index}`
  if (mediaCache[cacheKey]) {
    return mediaCache[cacheKey]
  }

  const images = sampleImages[category]
  const imageInfo = images[index % images.length]
  const filename = `${category}-${index}.jpg`

  const mediaId = await uploadImageFromUrl(payload, imageInfo.url, imageInfo.alt, filename)
  if (mediaId) {
    mediaCache[cacheKey] = mediaId
  }
  return mediaId
}

const seed = async () => {
  const payload = await getPayload({ config })

  console.log('Seeding database...')

  // ============================================
  // ADMIN USER (ensure admin exists)
  // ============================================
  console.log('Ensuring admin user exists...')

  const adminEmail = process.env.ADMIN_EMAIL || 'admin@rwandaconnect.com'
  const adminPassword = process.env.ADMIN_PASSWORD || 'admin123456'

  const existingAdmin = await payload.find({
    collection: 'users',
    where: {
      email: { equals: adminEmail },
    },
    limit: 1,
  })

  if (existingAdmin.docs.length === 0) {
    await payload.create({
      collection: 'users',
      data: {
        email: adminEmail,
        password: adminPassword,
        role: 'admin',
        contributorStatus: 'approved',
        name: 'Admin User',
      },
      overrideAccess: true,
    })
    console.log(`Created admin user: ${adminEmail}`)
  } else {
    // Ensure existing user is admin
    await payload.update({
      collection: 'users',
      id: existingAdmin.docs[0].id,
      data: {
        role: 'admin',
        contributorStatus: 'approved',
      },
      overrideAccess: true,
    })
    console.log(`Admin user already exists: ${adminEmail}`)
  }

  // ============================================
  // NEWS (15 articles)
  // ============================================
  console.log('Creating news articles...')

  const newsData: Array<{
    title: string
    source: string
    category: NewsCategory
    summary: string
    url: string
    publishDate: string
    isFeatured: boolean
  }> = [
    {
      title: 'Diaspora Remittances Hit Record $500M in 2025',
      source: 'The New Times',
      category: 'Economy',
      summary: 'Rwanda received a record $500 million in diaspora remittances in 2025, marking a 15% increase from the previous year. The Central Bank attributes this growth to improved digital transfer channels.',
      url: 'https://newtimes.co.rw/economy/remittances-record',
      publishDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'Rwanda GDP Growth Projected at 8.5% for 2026',
      source: 'The New Times',
      category: 'Economy',
      summary: "The International Monetary Fund projects Rwanda's economy to grow by 8.5% in 2026, driven by services, tourism, and technology sectors.",
      url: 'https://newtimes.co.rw/economy/gdp-growth',
      publishDate: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'New Tax Incentives for Diaspora Investors Announced',
      source: 'Rwanda Today',
      category: 'Economy',
      summary: 'The Rwanda Development Board unveils new tax incentives specifically designed to attract diaspora investment in key sectors including manufacturing and ICT.',
      url: 'https://rwandatoday.rw/economy/tax-incentives',
      publishDate: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'Kigali Innovation City Opens Phase 2 for Investment',
      source: 'Igihe',
      category: 'Investment',
      summary: 'Kigali Innovation City announces Phase 2 development with $200M in investment opportunities for tech companies and diaspora entrepreneurs.',
      url: 'https://igihe.com/investment/kic-phase2',
      publishDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'Real Estate Boom: New Developments in Kigali Heights',
      source: 'The New Times',
      category: 'Investment',
      summary: 'Premium residential and commercial developments in Kigali Heights attract significant diaspora interest with flexible payment plans.',
      url: 'https://newtimes.co.rw/investment/kigali-heights',
      publishDate: new Date(Date.now() - 4 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'AgriTech Sector Attracts $50M in New Investments',
      source: 'Rwanda Today',
      category: 'Investment',
      summary: "Rwanda's agricultural technology sector sees surge in investment as startups revolutionize farming practices across the country.",
      url: 'https://rwandatoday.rw/investment/agritech',
      publishDate: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'Annual Diaspora Conference Set for December 2025',
      source: 'The New Times',
      category: 'Events',
      summary: 'Organizers announced the Rwanda Diaspora Global Convention 2025, bringing together Rwandans from over 50 countries to discuss investment and development.',
      url: 'https://newtimes.co.rw/events/diaspora-conference',
      publishDate: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'Rwanda Day Boston Announced for March 2026',
      source: 'Igihe',
      category: 'Events',
      summary: 'Rwanda Day returns to Boston in March 2026, featuring cultural celebrations, business networking, and community building activities.',
      url: 'https://igihe.com/events/rwanda-day-boston',
      publishDate: new Date(Date.now() - 6 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'BK Group Launches Diaspora Banking Package',
      source: 'The New Times',
      category: 'Business',
      summary: 'Bank of Kigali introduces comprehensive banking solutions for the diaspora including USD accounts, international transfers, and mortgage products.',
      url: 'https://newtimes.co.rw/business/bk-diaspora',
      publishDate: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'MTN Rwanda Partners with M-Pesa for Cross-Border Payments',
      source: 'Rwanda Today',
      category: 'Business',
      summary: 'New partnership enables seamless mobile money transfers between diaspora and families in Rwanda with reduced fees.',
      url: 'https://rwandatoday.rw/business/mtn-mpesa',
      publishDate: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'Zipline Expands Medical Drone Delivery Network',
      source: 'The New Times',
      category: 'Business',
      summary: 'Zipline Rwanda expands its drone delivery network to cover 100% of the country, delivering medical supplies to remote areas.',
      url: 'https://newtimes.co.rw/business/zipline-expansion',
      publishDate: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'Rwanda Introduces Digital Nomad Visa',
      source: 'Igihe',
      category: 'Policy',
      summary: 'Rwanda launches a new digital nomad visa program allowing remote workers to live and work in the country for up to 2 years.',
      url: 'https://igihe.com/policy/digital-nomad-visa',
      publishDate: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
    {
      title: 'New Property Ownership Laws Benefit Diaspora',
      source: 'The New Times',
      category: 'Policy',
      summary: 'Updated land registration laws simplify property ownership for Rwandans living abroad, with digital verification systems.',
      url: 'https://newtimes.co.rw/policy/property-laws',
      publishDate: new Date(Date.now() - 9 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'Dual Citizenship Application Process Streamlined',
      source: 'Rwanda Today',
      category: 'Policy',
      summary: 'Immigration announces simplified online process for diaspora dual citizenship applications with 30-day processing guarantee.',
      url: 'https://rwandatoday.rw/policy/dual-citizenship',
      publishDate: new Date(Date.now() - 12 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: false,
    },
    {
      title: 'Diaspora Services Portal Expansion Announced',
      source: 'The New Times',
      category: 'Policy',
      summary: 'A new online portal provides diaspora users with one place to find public-service information, business registration resources, and document guidance links.',
      url: 'https://newtimes.co.rw/policy/diaspora-portal',
      publishDate: new Date(Date.now() - 15 * 24 * 60 * 60 * 1000).toISOString(),
      isFeatured: true,
    },
  ]

  console.log('Uploading news images...')
  const newsMediaIds: (number | null)[] = []
  for (let i = 0; i < newsData.length; i++) {
    const mediaId = await getOrUploadImage(payload, 'news', i)
    newsMediaIds.push(mediaId)
  }

  for (let i = 0; i < newsData.length; i++) {
    await payload.create({
      collection: 'news',
      data: {
        ...newsData[i],
        image: newsMediaIds[i] ?? undefined,
      },
    })
  }
  console.log(`Created ${newsData.length} news articles with images`)

  // ============================================
  // OPPORTUNITIES (20 listings)
  // ============================================
  console.log('Creating opportunities...')

  const opportunitiesData: Array<{
    type: OpportunityType
    title: string
    company: string
    location: string
    description?: string
    requirements: Array<{ requirement: string }>
    salary?: number
    salaryCurrency?: string
    deadline: string
    applyUrl: string
    verified: boolean
    isFeatured: boolean
    datePosted: string
  }> = [
    // Jobs
    {
      type: 'job',
      title: 'Senior Software Engineer',
      company: 'PayRwanda Ltd',
      location: 'Kigali, Rwanda',
      description: 'Join our fintech team building the next generation of payment solutions for Rwanda and East Africa. You will lead development of our mobile banking platform serving millions of users.',
      requirements: [
        { requirement: '5+ years software development experience' },
        { requirement: 'Strong in Python, Node.js, or Go' },
        { requirement: 'Experience with microservices architecture' },
        { requirement: 'Fintech experience preferred' },
      ],
      salary: 55000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://payrwanda.com/careers/senior-engineer',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'Product Manager - Mobile Apps',
      company: 'Irembo',
      location: 'Kigali, Rwanda',
      description: "Lead product strategy for one of Rwanda's largest digital public-service platforms. Drive user experience improvements serving millions of users.",
      requirements: [
        { requirement: '3+ years product management experience' },
        { requirement: 'Experience with mobile applications' },
        { requirement: 'Strong analytical and communication skills' },
        { requirement: 'French or Kinyarwanda is a plus' },
      ],
      salary: 48000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 21 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://irembo.gov.rw/careers/pm',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'Data Scientist',
      company: 'Bank of Kigali',
      location: 'Kigali, Rwanda',
      description: "Build ML models to improve credit scoring, fraud detection, and customer insights for Rwanda's largest bank.",
      requirements: [
        { requirement: 'Masters in Data Science, Statistics, or related field' },
        { requirement: 'Proficiency in Python, R, and SQL' },
        { requirement: '2+ years experience in financial services' },
        { requirement: 'Experience with ML frameworks' },
      ],
      salary: 52000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 45 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://bk.rw/careers/data-scientist',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'Marketing Director',
      company: 'Visit Rwanda',
      location: 'Kigali, Rwanda',
      description: 'Lead global marketing campaigns promoting Rwanda as a premier tourist and business destination.',
      requirements: [
        { requirement: '10+ years marketing experience' },
        { requirement: 'Experience in tourism or hospitality industry' },
        { requirement: 'Proven track record of successful campaigns' },
        { requirement: 'Strong leadership skills' },
      ],
      salary: 75000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 60 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://visitrwanda.com/careers/marketing-director',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'Full Stack Developer',
      company: 'Andela Rwanda',
      location: 'Kigali, Rwanda (Hybrid)',
      description: 'Build scalable web applications for global clients. Work with cutting-edge technologies in a collaborative environment.',
      requirements: [
        { requirement: '3+ years full stack development' },
        { requirement: 'React, Node.js, PostgreSQL expertise' },
        { requirement: 'Experience with cloud platforms (AWS/GCP)' },
        { requirement: 'Strong problem-solving skills' },
      ],
      salary: 42000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://andela.com/careers/fullstack-rw',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'Healthcare Administrator',
      company: 'King Faisal Hospital',
      location: 'Kigali, Rwanda',
      description: "Oversee daily operations and strategic planning for East Africa's leading referral hospital.",
      requirements: [
        { requirement: 'MBA or MHA degree' },
        { requirement: '7+ years healthcare administration' },
        { requirement: 'Experience with hospital management systems' },
        { requirement: 'Fluent in English' },
      ],
      salary: 60000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 35 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://kfh.rw/careers/admin',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'job',
      title: 'DevOps Engineer',
      company: 'AC Group',
      location: 'Kigali, Rwanda (Remote)',
      description: 'Build and maintain cloud infrastructure for pan-African tech solutions.',
      requirements: [
        { requirement: '4+ years DevOps experience' },
        { requirement: 'Kubernetes, Docker, Terraform expertise' },
        { requirement: 'AWS or GCP certification preferred' },
        { requirement: 'CI/CD pipeline experience' },
      ],
      salary: 50000,
      salaryCurrency: 'USD',
      deadline: new Date(Date.now() + 28 * 24 * 60 * 60 * 1000).toISOString(),
      applyUrl: 'https://acgroup.rw/careers/devops',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 6 * 24 * 60 * 60 * 1000).toISOString(),
    },
    // Investments
    {
      type: 'investment',
      title: 'AgriTech Startup - Series A',
      company: 'Rwanda AgriTech Hub',
      location: 'Kigali, Rwanda',
      description: 'Investment opportunity in a promising agricultural technology startup revolutionizing smallholder farming with IoT and data analytics. Targeting $5M raise.',
      requirements: [
        { requirement: 'Minimum investment: $50,000' },
        { requirement: 'Projected ROI: 25% over 5 years' },
        { requirement: 'Board observer seat for $250K+' },
      ],
      applyUrl: 'https://agrihub.rw/invest/series-a',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 90 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'investment',
      title: 'Kigali Heights Commercial Complex',
      company: 'Prime Real Estate Rwanda',
      location: 'Kigali, Rwanda',
      description: "Premium commercial real estate investment in Kigali's business district. Mixed-use development with retail, office, and residential units.",
      requirements: [
        { requirement: 'Minimum investment: $100,000' },
        { requirement: 'Expected rental yield: 12% annually' },
        { requirement: 'Flexible payment plans available' },
      ],
      applyUrl: 'https://primerealestate.rw/kigali-heights',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 15 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 120 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'investment',
      title: 'Solar Energy Fund',
      company: 'Rwanda Green Energy',
      location: 'Nationwide, Rwanda',
      description: 'Join the renewable energy revolution. Fund supports solar installations across rural Rwanda with long-term commercial offtake agreements.',
      requirements: [
        { requirement: 'Minimum investment: $25,000' },
        { requirement: 'Long-term power purchase agreements' },
        { requirement: '10-year investment horizon' },
      ],
      applyUrl: 'https://greenenergy.rw/solar-fund',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 20 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 60 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'investment',
      title: 'Tourism Lodge Development',
      company: 'Akagera Ventures',
      location: 'Akagera National Park, Rwanda',
      description: 'Eco-lodge development in partnership with African Parks. Premium safari experience targeting high-end tourists.',
      requirements: [
        { requirement: 'Minimum investment: $200,000' },
        { requirement: 'Partnership with African Parks' },
        { requirement: 'Projected 18% annual returns' },
      ],
      applyUrl: 'https://akageraventures.rw/lodge-investment',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 12 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 75 * 24 * 60 * 60 * 1000).toISOString(),
    },
    // Scholarships
    {
      type: 'scholarship',
      title: 'Carnegie Mellon Africa Full Scholarship',
      company: 'CMU Africa',
      location: 'Kigali, Rwanda',
      description: 'Full scholarship for Masters in Information Technology at Carnegie Mellon University Africa. Covers tuition, accommodation, and living expenses.',
      requirements: [
        { requirement: "Bachelor's degree in relevant field" },
        { requirement: 'Minimum GPA: 3.0' },
        { requirement: 'Strong quantitative background' },
        { requirement: 'Diaspora applicants encouraged' },
      ],
      applyUrl: 'https://cmu.africa/scholarship',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 45 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'scholarship',
      title: 'Rwanda STEM Scholarship',
      company: 'Ministry of Education',
      location: 'Various, Rwanda',
      description: 'Scholarship program for diaspora youth to study STEM subjects at Rwandan universities.',
      requirements: [
        { requirement: 'Age 18-25' },
        { requirement: 'Rwandan heritage' },
        { requirement: 'High school diploma with strong math/science grades' },
        { requirement: 'Commitment to work in Rwanda for 3 years' },
      ],
      applyUrl: 'https://mineduc.gov.rw/diaspora-scholarship',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 60 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'scholarship',
      title: 'African Leadership University Merit Award',
      company: 'ALU Rwanda',
      location: 'Kigali, Rwanda',
      description: 'Merit-based scholarship covering 50-100% of tuition for undergraduate programs in Business, Engineering, or Computer Science.',
      requirements: [
        { requirement: 'Strong academic record' },
        { requirement: 'Leadership experience' },
        { requirement: 'Community involvement' },
        { requirement: 'Essay required' },
      ],
      applyUrl: 'https://alueducation.com/scholarship',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'scholarship',
      title: 'Mastercard Foundation Scholars Program',
      company: 'University of Rwanda',
      location: 'Kigali, Rwanda',
      description: 'Comprehensive scholarship for academically talented students from economically disadvantaged backgrounds.',
      requirements: [
        { requirement: 'Financial need demonstrated' },
        { requirement: 'Academic excellence' },
        { requirement: 'Leadership potential' },
        { requirement: 'Community service orientation' },
      ],
      applyUrl: 'https://ur.ac.rw/mastercard-scholars',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 55 * 24 * 60 * 60 * 1000).toISOString(),
    },
    // Tenders
    {
      type: 'tender',
      title: 'ICT Infrastructure Development',
      company: 'Rwanda Information Society Authority',
      location: 'Nationwide, Rwanda',
      description: 'Tender for nationwide 5G network infrastructure development. Multi-year contract valued at $50M.',
      requirements: [
        { requirement: 'Registered telecom infrastructure company' },
        { requirement: 'Previous experience in East Africa' },
        { requirement: 'Financial capacity demonstration required' },
        { requirement: 'Technical proposal required' },
      ],
      applyUrl: 'https://risa.gov.rw/tenders/5g-infrastructure',
      verified: true,
      isFeatured: true,
      datePosted: new Date(Date.now() - 4 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 40 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'tender',
      title: 'Hospital Equipment Supply',
      company: 'Rwanda Biomedical Center',
      location: 'Kigali, Rwanda',
      description: 'Supply of medical imaging equipment for district hospitals. Contract value: $8M.',
      requirements: [
        { requirement: 'ISO certified medical equipment supplier' },
        { requirement: 'After-sales service capability in Rwanda' },
        { requirement: 'Training provision required' },
      ],
      applyUrl: 'https://rbc.gov.rw/tenders/medical-equipment',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 6 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 25 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'tender',
      title: 'School Construction Project',
      company: 'Ministry of Education',
      location: 'Eastern Province, Rwanda',
      description: 'Construction of 10 secondary schools in Eastern Province. Total budget: $15M.',
      requirements: [
        { requirement: 'Licensed construction company' },
        { requirement: 'Previous education sector experience' },
        { requirement: 'Local partnership required for foreign companies' },
      ],
      applyUrl: 'https://mineduc.gov.rw/tenders/school-construction',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 9 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 50 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      type: 'tender',
      title: 'Agricultural Export Logistics',
      company: 'NAEB',
      location: 'Kigali, Rwanda',
      description: 'Logistics and cold chain management for horticultural exports. 3-year renewable contract.',
      requirements: [
        { requirement: 'Cold chain logistics experience' },
        { requirement: 'HACCP certification' },
        { requirement: 'Fleet of refrigerated vehicles' },
        { requirement: 'Experience with perishable goods' },
      ],
      applyUrl: 'https://naeb.gov.rw/tenders/export-logistics',
      verified: true,
      isFeatured: false,
      datePosted: new Date(Date.now() - 11 * 24 * 60 * 60 * 1000).toISOString(),
      deadline: new Date(Date.now() + 35 * 24 * 60 * 60 * 1000).toISOString(),
    },
  ]

  console.log('Uploading opportunity company logos...')
  const opportunityMediaIds: (number | null)[] = []
  for (let i = 0; i < opportunitiesData.length; i++) {
    const mediaId = await getOrUploadImage(payload, 'opportunities', i)
    opportunityMediaIds.push(mediaId)
  }

  for (let i = 0; i < opportunitiesData.length; i++) {
    await payload.create({
      collection: 'opportunities',
      data: {
        ...opportunitiesData[i],
        companyLogo: opportunityMediaIds[i] ?? undefined,
      },
    })
  }
  console.log(`Created ${opportunitiesData.length} opportunities with logos`)

  // ============================================
  // REAL ESTATE (Kigali launch listings)
  // ============================================
  console.log('Creating real estate listings...')

  const realEstateData: Array<{
    title: string
    category: RealEstateCategory
    listingType: RealEstateListingType
    description: string
    price: number
    currency: string
    location: string
    areaSqm: number
    bedrooms?: number
    bathrooms?: number
    contactPhone: string
    contactEmail: string
    isFeatured: boolean
    isAvailable: boolean
    datePosted: string
  }> = [
    {
      title: 'Modern 4-Bedroom House in Nyarutarama',
      category: 'house',
      listingType: 'sale',
      description:
        'Contemporary family home with garden, secure parking, and easy access to schools and shopping in Nyarutarama.',
      price: 420000,
      currency: 'USD',
      location: 'Nyarutarama, Kigali',
      areaSqm: 320,
      bedrooms: 4,
      bathrooms: 3,
      contactPhone: '+250788200101',
      contactEmail: 'sales@kigaliprime.rw',
      isFeatured: true,
      isAvailable: true,
      datePosted: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'Furnished 2-Bedroom Apartment in Kiyovu',
      category: 'apartment',
      listingType: 'rent',
      description:
        'Move-in ready apartment with city views, backup power, and high-speed internet near Kigali CBD.',
      price: 1800,
      currency: 'USD',
      location: 'Kiyovu, Kigali',
      areaSqm: 120,
      bedrooms: 2,
      bathrooms: 2,
      contactPhone: '+250788200102',
      contactEmail: 'rentals@kigaliprime.rw',
      isFeatured: true,
      isAvailable: true,
      datePosted: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'Prime Residential Land Plot - Rebero',
      category: 'land',
      listingType: 'sale',
      description:
        'Serviced residential plot with strong road access and panoramic city views, ideal for premium home development.',
      price: 135000,
      currency: 'USD',
      location: 'Rebero, Kigali',
      areaSqm: 850,
      contactPhone: '+250788200103',
      contactEmail: 'land@kigaliprime.rw',
      isFeatured: false,
      isAvailable: true,
      datePosted: new Date(Date.now() - 6 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: '3-Bedroom Family House in Kibagabaga',
      category: 'house',
      listingType: 'rent',
      description:
        'Spacious house in a quiet neighborhood with private compound and quick access to major roads.',
      price: 2200,
      currency: 'USD',
      location: 'Kibagabaga, Kigali',
      areaSqm: 260,
      bedrooms: 3,
      bathrooms: 2,
      contactPhone: '+250788200104',
      contactEmail: 'homes@kigaliprime.rw',
      isFeatured: false,
      isAvailable: true,
      datePosted: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'Luxury Penthouse Apartment - Kimihurura',
      category: 'apartment',
      listingType: 'sale',
      description:
        'High-end penthouse with rooftop terrace, smart-home setup, and premium finishing in central Kigali.',
      price: 560000,
      currency: 'USD',
      location: 'Kimihurura, Kigali',
      areaSqm: 280,
      bedrooms: 3,
      bathrooms: 3,
      contactPhone: '+250788200105',
      contactEmail: 'premium@kigaliprime.rw',
      isFeatured: true,
      isAvailable: true,
      datePosted: new Date(Date.now() - 5 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'Commercial Development Land - Kicukiro',
      category: 'land',
      listingType: 'sale',
      description:
        'Strategic commercial plot near key transport routes, suitable for mixed-use development.',
      price: 295000,
      currency: 'USD',
      location: 'Kicukiro, Kigali',
      areaSqm: 1400,
      contactPhone: '+250788200106',
      contactEmail: 'investment@kigaliprime.rw',
      isFeatured: false,
      isAvailable: true,
      datePosted: new Date(Date.now() - 8 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'Executive 1-Bedroom Apartment - Gacuriro',
      category: 'apartment',
      listingType: 'rent',
      description:
        'Secure serviced apartment for professionals, including parking, concierge, and gym access.',
      price: 1200,
      currency: 'USD',
      location: 'Gacuriro, Kigali',
      areaSqm: 78,
      bedrooms: 1,
      bathrooms: 1,
      contactPhone: '+250788200107',
      contactEmail: 'leasing@kigaliprime.rw',
      isFeatured: false,
      isAvailable: true,
      datePosted: new Date(Date.now() - 4 * 24 * 60 * 60 * 1000).toISOString(),
    },
    {
      title: 'New Build 5-Bedroom Villa - Rusororo',
      category: 'house',
      listingType: 'sale',
      description:
        'Newly built villa with modern architecture, staff quarters, and large compound close to the airport corridor.',
      price: 680000,
      currency: 'USD',
      location: 'Rusororo, Kigali',
      areaSqm: 520,
      bedrooms: 5,
      bathrooms: 4,
      contactPhone: '+250788200108',
      contactEmail: 'villas@kigaliprime.rw',
      isFeatured: true,
      isAvailable: true,
      datePosted: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString(),
    },
  ]

  console.log('Uploading real estate images...')
  const realEstateMediaIds: (number | null)[] = []
  for (let i = 0; i < realEstateData.length; i++) {
    const mediaId = await getOrUploadImage(payload, 'realEstate', i)
    realEstateMediaIds.push(mediaId)
  }

  let createdRealEstate = 0
  let updatedRealEstate = 0

  for (let i = 0; i < realEstateData.length; i++) {
    const listing = realEstateData[i]
    const imageId = realEstateMediaIds[i]

    const existing = await payload.find({
      collection: 'real-estate',
      where: {
        and: [
          { title: { equals: listing.title } },
          { category: { equals: listing.category } },
          { listingType: { equals: listing.listingType } },
          { location: { equals: listing.location } },
        ],
      },
      limit: 1,
    })

    const dataWithImage = {
      ...listing,
      images: imageId ? [imageId] : undefined,
    }

    if (existing.totalDocs > 0) {
      await payload.update({
        collection: 'real-estate',
        id: existing.docs[0].id,
        data: dataWithImage,
      })
      updatedRealEstate += 1
    } else {
      await payload.create({
        collection: 'real-estate',
        data: dataWithImage,
      })
      createdRealEstate += 1
    }
  }
  console.log(`Created ${createdRealEstate} real estate listings with images`)
  console.log(`Updated ${updatedRealEstate} existing real estate listings`)

  // ============================================
  // EVENTS (15 events)
  // ============================================
  console.log('Creating events...')

  const eventsData: Array<{
    title: string
    description: string
    type: EventType
    organizer: string
    location: string
    venue: string
    date: string
    endDate?: string
    capacity: number
    price: number
    currency: string
    isVirtual: boolean
    virtualLink?: string
    isFeatured: boolean
  }> = [
    // Networking Events
    {
      title: 'Rwanda Connect Toronto Networking Night',
      description: 'Join fellow Rwandan professionals in Toronto for an evening of networking, knowledge sharing, and community building. Light refreshments provided.',
      type: 'networking',
      organizer: 'Rwanda Connect Toronto',
      location: 'Toronto, Canada',
      venue: 'The Globe and Mail Centre',
      date: new Date(Date.now() + 14 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 100,
      price: 25,
      currency: 'CAD',
      isVirtual: false,
      isFeatured: true,
    },
    {
      title: 'Diaspora Professionals Mixer - London',
      description: 'Monthly networking event for Rwandan professionals in London. Great opportunity to connect with others in finance, tech, and healthcare sectors.',
      type: 'networking',
      organizer: 'Rwanda UK Network',
      location: 'London, United Kingdom',
      venue: 'WeWork Moorgate',
      date: new Date(Date.now() + 21 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 75,
      price: 15,
      currency: 'GBP',
      isVirtual: false,
      isFeatured: false,
    },
    {
      title: 'Kigali Tech Meetup',
      description: 'Weekly gathering of tech enthusiasts, developers, and entrepreneurs. This week: AI and Machine Learning in Rwanda.',
      type: 'networking',
      organizer: 'Kigali Tech Community',
      location: 'Kigali, Rwanda',
      venue: 'The Office Kigali',
      date: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 50,
      price: 0,
      currency: 'RWF',
      isVirtual: false,
      isFeatured: false,
    },
    {
      title: 'Women in Business Rwanda Chapter',
      description: 'Networking breakfast for women entrepreneurs and professionals. Featuring speaker from Bank of Kigali on access to finance.',
      type: 'networking',
      organizer: 'Women in Business Africa',
      location: 'Kigali, Rwanda',
      venue: 'Marriott Kigali',
      date: new Date(Date.now() + 10 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 60,
      price: 15000,
      currency: 'RWF',
      isVirtual: false,
      isFeatured: true,
    },
    // Seminars
    {
      title: 'Investing in Rwanda Real Estate - Webinar',
      description: 'Comprehensive guide to property investment in Rwanda for diaspora. Topics include legal framework, financing options, and market trends.',
      type: 'seminar',
      organizer: 'Diaspora Investment Desk',
      location: 'Virtual',
      venue: 'Zoom',
      date: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 500,
      price: 0,
      currency: 'USD',
      isVirtual: true,
      virtualLink: 'https://zoom.us/j/example',
      isFeatured: true,
    },
    {
      title: 'Tax Planning for Diaspora Investors',
      description: 'Learn about tax implications and benefits for diaspora investing in Rwanda. Presented by RRA and PwC Rwanda.',
      type: 'seminar',
      organizer: 'Tax Advisory Forum',
      location: 'Virtual',
      venue: 'Microsoft Teams',
      date: new Date(Date.now() + 12 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 300,
      price: 0,
      currency: 'USD',
      isVirtual: true,
      virtualLink: 'https://teams.microsoft.com/example',
      isFeatured: false,
    },
    {
      title: 'Starting a Business in Rwanda',
      description: 'Step-by-step guide to company registration, licensing, and compliance. Interactive session with RDB business registration team.',
      type: 'seminar',
      organizer: 'Business Support Hub Rwanda',
      location: 'Kigali, Rwanda',
      venue: 'RDB Headquarters',
      date: new Date(Date.now() + 18 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 100,
      price: 0,
      currency: 'USD',
      isVirtual: false,
      isFeatured: false,
    },
    // Workshops
    {
      title: 'Diaspora Investment Workshop',
      description: 'Hands-on workshop covering investment opportunities in agriculture, real estate, and technology. Includes site visits.',
      type: 'workshop',
      organizer: 'Diaspora Investment Office',
      location: 'Kigali, Rwanda',
      venue: 'Kigali Convention Centre',
      date: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 31 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 150,
      price: 50,
      currency: 'USD',
      isVirtual: false,
      isFeatured: true,
    },
    {
      title: 'Tech Entrepreneurship Bootcamp',
      description: 'Intensive 2-day bootcamp for aspiring tech entrepreneurs. Learn product development, fundraising, and scaling strategies.',
      type: 'workshop',
      organizer: 'Norrsken Kigali',
      location: 'Kigali, Rwanda',
      venue: 'Norrsken House Kigali',
      date: new Date(Date.now() + 25 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 26 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 40,
      price: 100,
      currency: 'USD',
      isVirtual: false,
      isFeatured: true,
    },
    {
      title: 'Grant Writing Workshop',
      description: 'Learn how to write successful grant proposals for NGOs and social enterprises operating in Rwanda.',
      type: 'workshop',
      organizer: 'Rwanda Civil Society Platform',
      location: 'Kigali, Rwanda',
      venue: 'Lemigo Hotel',
      date: new Date(Date.now() + 20 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 35,
      price: 25000,
      currency: 'RWF',
      isVirtual: false,
      isFeatured: false,
    },
    // Conferences
    {
      title: 'Kigali Tech Summit 2026',
      description: 'Annual technology conference bringing together innovators from Africa and the diaspora. Keynotes, panels, and startup showcases.',
      type: 'conference',
      organizer: 'Rwanda ICT Chamber',
      location: 'Kigali, Rwanda',
      venue: 'Kigali Convention Centre',
      date: new Date(Date.now() + 60 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 62 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 1000,
      price: 150,
      currency: 'USD',
      isVirtual: false,
      isFeatured: true,
    },
    {
      title: 'Rwanda Diaspora Global Convention',
      description: 'The flagship annual gathering of Rwandans from around the world, featuring policy discussions, business leaders, and community sessions.',
      type: 'conference',
      organizer: 'Diaspora Affairs Forum',
      location: 'Kigali, Rwanda',
      venue: 'Kigali Convention Centre',
      date: new Date(Date.now() + 90 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 92 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 2000,
      price: 0,
      currency: 'USD',
      isVirtual: false,
      isFeatured: true,
    },
    {
      title: 'East Africa Investment Forum',
      description: 'Regional investment conference featuring opportunities across Rwanda, Kenya, Tanzania, and Uganda.',
      type: 'conference',
      organizer: 'East African Business Council',
      location: 'Kigali, Rwanda',
      venue: 'Radisson Blu Kigali',
      date: new Date(Date.now() + 45 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 46 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 500,
      price: 200,
      currency: 'USD',
      isVirtual: false,
      isFeatured: false,
    },
    {
      title: 'Africa Healthcare Summit',
      description: 'Conference on healthcare innovation and investment opportunities in Africa. Focus on digital health and medical tourism.',
      type: 'conference',
      organizer: 'Africa Health Business',
      location: 'Kigali, Rwanda',
      venue: 'Marriott Kigali',
      date: new Date(Date.now() + 75 * 24 * 60 * 60 * 1000).toISOString(),
      endDate: new Date(Date.now() + 76 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 400,
      price: 175,
      currency: 'USD',
      isVirtual: false,
      isFeatured: false,
    },
    {
      title: 'Rwanda Day Brussels 2026',
      description: 'Cultural celebration and community gathering for Rwandans in Belgium and Europe. Music, food, and networking.',
      type: 'conference',
      organizer: 'Rwanda Community Belgium',
      location: 'Brussels, Belgium',
      venue: 'Brussels Expo',
      date: new Date(Date.now() + 120 * 24 * 60 * 60 * 1000).toISOString(),
      capacity: 3000,
      price: 20,
      currency: 'EUR',
      isVirtual: false,
      isFeatured: true,
    },
  ]

  console.log('Uploading event images...')
  const eventMediaIds: (number | null)[] = []
  for (let i = 0; i < eventsData.length; i++) {
    const mediaId = await getOrUploadImage(payload, 'events', i)
    eventMediaIds.push(mediaId)
  }

  for (let i = 0; i < eventsData.length; i++) {
    await payload.create({
      collection: 'events',
      data: {
        ...eventsData[i],
        image: eventMediaIds[i] ?? undefined,
      },
    })
  }
  console.log(`Created ${eventsData.length} events with images`)

  // ============================================
  // COMMUNITY POSTS (10 sample posts)
  // ============================================
  console.log('Creating community posts...')

  // First, get or create a user for the posts
  const existingUsers = await payload.find({
    collection: 'users',
    limit: 1,
  })

  let authorId: number

  if (existingUsers.docs.length > 0) {
    authorId = existingUsers.docs[0].id as number
  } else {
    const newUser = await payload.create({
      collection: 'users',
      draft: false,
      data: {
        email: 'community@rwandaconnect.com',
        password: 'community123',
        role: 'user' as const,
        contributorStatus: 'pending' as const,
      },
    })
    authorId = newUser.id as number
  }

  const postsData = [
    {
      author: authorId,
      content: 'Just moved back to Kigali after 10 years in the US. The transformation is incredible! Looking forward to connecting with fellow returnees.',
      isPinned: true,
      likesCount: 45,
      commentsCount: 12,
    },
    {
      author: authorId,
      content: 'Anyone have recommendations for good schools in Kigali for elementary-aged children? We are relocating next year.',
      isPinned: false,
      likesCount: 23,
      commentsCount: 18,
    },
    {
      author: authorId,
      content: 'Excited to announce that our diaspora-funded startup just secured Series A funding! Thank you to everyone who believed in us.',
      isPinned: false,
      likesCount: 89,
      commentsCount: 34,
    },
    {
      author: authorId,
      content: 'Tips for those sending money home: I have been using the new BK diaspora transfer service and the rates are much better than Western Union.',
      isPinned: false,
      likesCount: 67,
      commentsCount: 21,
    },
    {
      author: authorId,
      content: 'Looking for partners for an agribusiness venture in Eastern Province. Coffee processing facility. DM if interested.',
      isPinned: false,
      likesCount: 34,
      commentsCount: 8,
    },
    {
      author: authorId,
      content: 'The Rwanda Day event in Boston was amazing! Great to see so many fellow Rwandans. Who else attended?',
      isPinned: false,
      likesCount: 56,
      commentsCount: 27,
    },
    {
      author: authorId,
      content: 'Question: What is the process for getting a construction permit in Kigali? Planning to build on family land.',
      isPinned: false,
      likesCount: 19,
      commentsCount: 15,
    },
    {
      author: authorId,
      content: 'Sharing my experience with the digital nomad visa - the process was smooth and I am now working remotely from Kigali. Happy to answer questions!',
      isPinned: true,
      likesCount: 78,
      commentsCount: 42,
    },
    {
      author: authorId,
      content: 'Reminder: The Mastercard Foundation scholarship deadline is coming up. Great opportunity for young Rwandans!',
      isPinned: false,
      likesCount: 41,
      commentsCount: 5,
    },
    {
      author: authorId,
      content: 'Just completed the dual citizenship application online. Took about 45 days total. The new system is much faster than before.',
      isPinned: false,
      likesCount: 52,
      commentsCount: 16,
    },
  ]

  for (const post of postsData) {
    await payload.create({
      collection: 'community-posts',
      data: post,
    })
  }
  console.log(`Created ${postsData.length} community posts`)

  // ============================================
  // BUSINESS DIRECTORY (Kigali launch)
  // ============================================
  console.log('Creating business directory launch data...')

  const kigaliLaunchDirectoryCategories: BusinessDirectoryCategory[] = [
    'real_estate',
    'hospitality',
    'retail',
    'professional_services',
    'technology',
    'health',
  ]

  const businessDirectoryData: Array<{
    owner: number
    name: string
    slug: string
    category: BusinessDirectoryCategory
    subcategory: string
    description: string
    phone: string
    email: string
    website: string
    address: string
    city: string
    district: string
    country: string
    geo: {
      latitude: number
      longitude: number
    }
    services: Array<{ service: string }>
    tags: Array<{ tag: string }>
    businessHours: Array<{
      day: 'monday' | 'tuesday' | 'wednesday' | 'thursday' | 'friday' | 'saturday' | 'sunday'
      openTime?: string
      closeTime?: string
      isClosed: boolean
    }>
    status: 'approved'
    isFeatured: boolean
    isActive: boolean
    dateListed: string
  }> = [
    {
      owner: authorId,
      name: 'Kigali Prime Properties',
      slug: 'kigali-prime-properties',
      category: 'real_estate',
      subcategory: 'Residential & Commercial',
      description:
        'Property brokerage focused on Kigali residential homes, serviced apartments, and office spaces for diaspora clients.',
      phone: '+250788100101',
      email: 'hello@kigaliprime.rw',
      website: 'https://kigaliprime.rw',
      address: 'KG 7 Ave, Nyarutarama',
      city: 'Kigali',
      district: 'Gasabo',
      country: 'Rwanda',
      geo: { latitude: -1.9441, longitude: 30.0937 },
      services: [
        { service: 'Property Sales' },
        { service: 'Property Rentals' },
        { service: 'Investment Advisory' },
      ],
      tags: [{ tag: 'real-estate' }, { tag: 'diaspora' }, { tag: 'kigali' }],
      businessHours: [
        { day: 'monday', openTime: '08:00', closeTime: '18:00', isClosed: false },
        { day: 'tuesday', openTime: '08:00', closeTime: '18:00', isClosed: false },
        { day: 'wednesday', openTime: '08:00', closeTime: '18:00', isClosed: false },
        { day: 'thursday', openTime: '08:00', closeTime: '18:00', isClosed: false },
        { day: 'friday', openTime: '08:00', closeTime: '18:00', isClosed: false },
        { day: 'saturday', openTime: '09:00', closeTime: '14:00', isClosed: false },
        { day: 'sunday', isClosed: true },
      ],
      status: 'approved',
      isFeatured: true,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
    {
      owner: authorId,
      name: 'Inzora Hospitality Group',
      slug: 'inzora-hospitality-group',
      category: 'hospitality',
      subcategory: 'Boutique Hotel & Events',
      description:
        'Boutique accommodation and event hosting services for business travelers and diaspora family visits in Kigali.',
      phone: '+250788100102',
      email: 'bookings@inzorahospitality.rw',
      website: 'https://inzorahospitality.rw',
      address: 'KN 41 St, Kiyovu',
      city: 'Kigali',
      district: 'Nyarugenge',
      country: 'Rwanda',
      geo: { latitude: -1.9512, longitude: 30.0619 },
      services: [
        { service: 'Hotel Booking' },
        { service: 'Airport Transfer' },
        { service: 'Conference Hosting' },
      ],
      tags: [{ tag: 'hospitality' }, { tag: 'travel' }, { tag: 'events' }],
      businessHours: [
        { day: 'monday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'tuesday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'wednesday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'thursday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'friday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'saturday', openTime: '00:00', closeTime: '23:59', isClosed: false },
        { day: 'sunday', openTime: '00:00', closeTime: '23:59', isClosed: false },
      ],
      status: 'approved',
      isFeatured: true,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
    {
      owner: authorId,
      name: 'Kimironko Retail Hub',
      slug: 'kimironko-retail-hub',
      category: 'retail',
      subcategory: 'Home & Lifestyle',
      description:
        'Modern retail collective connecting curated local products with reliable fulfillment and delivery in Kigali.',
      phone: '+250788100103',
      email: 'support@kimironkohub.rw',
      website: 'https://kimironkohub.rw',
      address: 'KG 11 Ave, Kimironko',
      city: 'Kigali',
      district: 'Gasabo',
      country: 'Rwanda',
      geo: { latitude: -1.9367, longitude: 30.1239 },
      services: [
        { service: 'Home Goods' },
        { service: 'Gift Items' },
        { service: 'Local Delivery' },
      ],
      tags: [{ tag: 'retail' }, { tag: 'ecommerce' }, { tag: 'local-products' }],
      businessHours: [
        { day: 'monday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'tuesday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'wednesday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'thursday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'friday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'saturday', openTime: '09:00', closeTime: '20:00', isClosed: false },
        { day: 'sunday', openTime: '10:00', closeTime: '17:00', isClosed: false },
      ],
      status: 'approved',
      isFeatured: false,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
    {
      owner: authorId,
      name: 'Kigali Legal Advisory',
      slug: 'kigali-legal-advisory',
      category: 'professional_services',
      subcategory: 'Legal & Compliance',
      description:
        'Legal advisory for company setup, contracts, and compliance support tailored to diaspora founders and investors.',
      phone: '+250788100104',
      email: 'info@kigalilegal.rw',
      website: 'https://kigalilegal.rw',
      address: 'KN 5 Rd, City Centre',
      city: 'Kigali',
      district: 'Nyarugenge',
      country: 'Rwanda',
      geo: { latitude: -1.9499, longitude: 30.0588 },
      services: [
        { service: 'Business Registration Support' },
        { service: 'Contract Drafting' },
        { service: 'Regulatory Compliance' },
      ],
      tags: [{ tag: 'legal' }, { tag: 'compliance' }, { tag: 'business' }],
      businessHours: [
        { day: 'monday', openTime: '08:30', closeTime: '17:30', isClosed: false },
        { day: 'tuesday', openTime: '08:30', closeTime: '17:30', isClosed: false },
        { day: 'wednesday', openTime: '08:30', closeTime: '17:30', isClosed: false },
        { day: 'thursday', openTime: '08:30', closeTime: '17:30', isClosed: false },
        { day: 'friday', openTime: '08:30', closeTime: '17:30', isClosed: false },
        { day: 'saturday', isClosed: true },
        { day: 'sunday', isClosed: true },
      ],
      status: 'approved',
      isFeatured: false,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
    {
      owner: authorId,
      name: 'Norrsken Growth Studio Kigali',
      slug: 'norrsken-growth-studio-kigali',
      category: 'technology',
      subcategory: 'Startup Studio',
      description:
        'Technology studio and coworking ecosystem supporting founders with product strategy, engineering support, and fundraising.',
      phone: '+250788100105',
      email: 'hello@norrskenkigali.rw',
      website: 'https://norrskenkigali.rw',
      address: 'KG 9 Ave, Kacyiru',
      city: 'Kigali',
      district: 'Gasabo',
      country: 'Rwanda',
      geo: { latitude: -1.9448, longitude: 30.0875 },
      services: [
        { service: 'Coworking Space' },
        { service: 'Startup Advisory' },
        { service: 'Tech Talent Network' },
      ],
      tags: [{ tag: 'technology' }, { tag: 'startup' }, { tag: 'innovation' }],
      businessHours: [
        { day: 'monday', openTime: '08:00', closeTime: '20:00', isClosed: false },
        { day: 'tuesday', openTime: '08:00', closeTime: '20:00', isClosed: false },
        { day: 'wednesday', openTime: '08:00', closeTime: '20:00', isClosed: false },
        { day: 'thursday', openTime: '08:00', closeTime: '20:00', isClosed: false },
        { day: 'friday', openTime: '08:00', closeTime: '20:00', isClosed: false },
        { day: 'saturday', openTime: '09:00', closeTime: '17:00', isClosed: false },
        { day: 'sunday', isClosed: true },
      ],
      status: 'approved',
      isFeatured: true,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
    {
      owner: authorId,
      name: 'Kigali Family Health Center',
      slug: 'kigali-family-health-center',
      category: 'health',
      subcategory: 'Primary Care',
      description:
        'Community-focused clinic delivering primary healthcare, preventive screenings, and telemedicine consultations.',
      phone: '+250788100106',
      email: 'care@kigalifamilyhealth.rw',
      website: 'https://kigalifamilyhealth.rw',
      address: 'KK 15 Rd, Kicukiro',
      city: 'Kigali',
      district: 'Kicukiro',
      country: 'Rwanda',
      geo: { latitude: -1.969, longitude: 30.1022 },
      services: [
        { service: 'General Consultation' },
        { service: 'Preventive Screening' },
        { service: 'Telemedicine' },
      ],
      tags: [{ tag: 'health' }, { tag: 'clinic' }, { tag: 'wellness' }],
      businessHours: [
        { day: 'monday', openTime: '07:30', closeTime: '19:00', isClosed: false },
        { day: 'tuesday', openTime: '07:30', closeTime: '19:00', isClosed: false },
        { day: 'wednesday', openTime: '07:30', closeTime: '19:00', isClosed: false },
        { day: 'thursday', openTime: '07:30', closeTime: '19:00', isClosed: false },
        { day: 'friday', openTime: '07:30', closeTime: '19:00', isClosed: false },
        { day: 'saturday', openTime: '08:00', closeTime: '14:00', isClosed: false },
        { day: 'sunday', isClosed: true },
      ],
      status: 'approved',
      isFeatured: false,
      isActive: true,
      dateListed: new Date().toISOString(),
    },
  ]

  console.log('Uploading business logos...')
  const businessMediaIds: (number | null)[] = []
  for (let i = 0; i < businessDirectoryData.length; i++) {
    const mediaId = await getOrUploadImage(payload, 'businesses', i)
    businessMediaIds.push(mediaId)
  }

  let createdBusinesses = 0
  let updatedBusinesses = 0

  for (let i = 0; i < businessDirectoryData.length; i++) {
    const business = businessDirectoryData[i]
    const logoId = businessMediaIds[i]

    const existing = await payload.find({
      collection: 'business-directory',
      where: {
        slug: { equals: business.slug },
      },
      limit: 1,
    })

    const dataWithLogo = {
      ...business,
      logo: logoId ?? undefined,
    }

    if (existing.totalDocs > 0) {
      await payload.update({
        collection: 'business-directory',
        id: existing.docs[0].id,
        data: dataWithLogo,
      })
      updatedBusinesses += 1
    } else {
      await payload.create({
        collection: 'business-directory',
        data: dataWithLogo,
      })
      createdBusinesses += 1
    }
  }

  console.log(
    `Business directory categories for Kigali launch: ${kigaliLaunchDirectoryCategories.join(', ')}`,
  )
  console.log(`Created ${createdBusinesses} business directory listings`)
  console.log(`Updated ${updatedBusinesses} existing business directory listings`)

  console.log('\nSeeding complete!')
  console.log('Summary:')
  console.log(`  - ${newsData.length} news articles`)
  console.log(`  - ${opportunitiesData.length} opportunities`)
  console.log(`  - ${realEstateData.length} real estate listings (created + updated)`)
  console.log(`  - ${eventsData.length} events`)
  console.log(`  - ${postsData.length} community posts`)
  console.log(`  - ${businessDirectoryData.length} business directory listings (created + updated)`)

  process.exit(0)
}

seed().catch((error) => {
  console.error('Seeding failed:', error)
  process.exit(1)
})

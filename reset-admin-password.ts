import 'dotenv/config'
import pg from 'pg'

const NEW_EMAIL = 'newadmin@rwandaconnect.com'
const NEW_PASSWORD = 'Admin@123!'

async function createNewAdmin() {
  const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
  })

  try {
    // Delete existing user with this email if exists
    await pool.query(`DELETE FROM users WHERE email = $1`, [NEW_EMAIL])

    console.log('Creating new admin user via Payload API...')
    console.log('This will use Payload\'s native password hashing.\n')

  } catch (error) {
    console.error('Error:', error)
  } finally {
    await pool.end()
  }
}

// Use Payload's API to create user with proper password hashing
import { getPayload } from 'payload'
import config from './src/payload.config'

async function main() {
  await createNewAdmin()

  const payload = await getPayload({ config })

  try {
    // Create new admin user using Payload's API
    const user = await payload.create({
      collection: 'users',
      data: {
        email: NEW_EMAIL,
        password: NEW_PASSWORD,
        role: 'admin',
        contributorStatus: 'approved',
      },
      overrideAccess: true,
    })

    console.log('✓ New admin user created!')
    console.log('Email:', NEW_EMAIL)
    console.log('Password:', NEW_PASSWORD)
    console.log('User ID:', user.id)

  } catch (error: any) {
    console.error('Error creating user:', error.message)
  }

  process.exit(0)
}

main()

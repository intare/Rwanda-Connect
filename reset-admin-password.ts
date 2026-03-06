import 'dotenv/config'
import { getPayload } from 'payload'
import config from './src/payload.config'

const NEW_PASSWORD = 'Admin@123!'

async function resetPassword() {
  const payload = await getPayload({ config })

  // First, find the admin user
  const users = await payload.find({
    collection: 'users',
    where: { role: { equals: 'admin' } },
    overrideAccess: true,
  })

  console.log(`Found ${users.docs.length} admin users:`)
  users.docs.forEach((u: any) => {
    console.log(`  - ID: ${u.id}, Email: ${u.email}`)
  })

  if (users.docs.length === 0) {
    console.log('No admin users found!')
    process.exit(1)
  }

  // Update password for first admin user by ID
  const adminUser = users.docs[0] as any
  console.log(`\nResetting password for: ${adminUser.email} (ID: ${adminUser.id})`)

  const updated = await payload.update({
    collection: 'users',
    id: adminUser.id,
    data: { password: NEW_PASSWORD },
    overrideAccess: true,
  })

  console.log('\nPassword reset successfully!')
  console.log('Email:', updated.email)
  console.log('Password:', NEW_PASSWORD)
  process.exit(0)
}

resetPassword().catch((err) => {
  console.error('Error:', err)
  process.exit(1)
})

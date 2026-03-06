import 'dotenv/config'
import { getPayload } from 'payload'
import config from './src/payload.config'

const NEW_PASSWORD = 'Admin@123!'

async function resetPassword() {
  const payload = await getPayload({ config })

  await payload.update({
    collection: 'users',
    where: { email: { equals: 'admin@rwandaconnect.com' } },
    data: { password: NEW_PASSWORD },
    overrideAccess: true,
  })

  console.log('Password reset successfully!')
  console.log('Email: admin@rwandaconnect.com')
  console.log('Password:', NEW_PASSWORD)
  process.exit(0)
}

resetPassword().catch(console.error)

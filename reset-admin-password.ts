import 'dotenv/config'
import pg from 'pg'
import { scrypt, randomBytes } from 'crypto'
import { promisify } from 'util'

const scryptAsync = promisify(scrypt)
const NEW_PASSWORD = 'Admin@123!'

async function resetPassword() {
  const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
  })

  try {
    // Check current hash format
    const current = await pool.query(
      `SELECT id, email, salt, hash FROM users WHERE role = 'admin' LIMIT 1`
    )

    if (current.rowCount === 0) {
      console.log('No admin users found!')
      process.exit(1)
    }

    const adminUser = current.rows[0]
    console.log('Admin user:', adminUser.email)
    console.log('Current salt length:', adminUser.salt?.length)
    console.log('Current hash length:', adminUser.hash?.length)
    console.log('Current salt sample:', adminUser.salt?.substring(0, 20))
    console.log('Current hash sample:', adminUser.hash?.substring(0, 20))

    // Generate new salt and hash using scrypt (Payload's method)
    const salt = randomBytes(32).toString('hex')
    const hash = ((await scryptAsync(NEW_PASSWORD, salt, 64)) as Buffer).toString('hex')

    console.log('\nNew salt length:', salt.length)
    console.log('New hash length:', hash.length)

    // Update salt and hash
    const result = await pool.query(
      `UPDATE users SET salt = $1, hash = $2 WHERE id = $3 RETURNING id, email`,
      [salt, hash, adminUser.id]
    )

    if (result.rowCount === 1) {
      console.log('\nPassword reset successfully!')
      console.log('Email:', adminUser.email)
      console.log('Password:', NEW_PASSWORD)
    } else {
      console.log('Failed to update password')
    }
  } catch (error) {
    console.error('Error:', error)
    process.exit(1)
  } finally {
    await pool.end()
  }
}

resetPassword()

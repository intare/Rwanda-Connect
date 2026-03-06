import 'dotenv/config'
import pg from 'pg'
import bcrypt from 'bcryptjs'

const NEW_PASSWORD = 'Admin@123!'

async function resetPassword() {
  const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
  })

  try {
    const current = await pool.query(
      `SELECT id, email, salt, hash FROM users WHERE role = 'admin' LIMIT 1`
    )

    if (current.rowCount === 0) {
      console.log('No admin users found!')
      process.exit(1)
    }

    const adminUser = current.rows[0]
    console.log('Admin user:', adminUser.email)

    // Generate bcrypt hash (includes salt in the hash string)
    const hash = await bcrypt.hash(NEW_PASSWORD, 10)

    // Extract salt portion from bcrypt hash (first 29 chars)
    const salt = hash.substring(0, 29)

    console.log('New salt:', salt)
    console.log('New hash:', hash)

    // Update both columns - Payload expects bcrypt format
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

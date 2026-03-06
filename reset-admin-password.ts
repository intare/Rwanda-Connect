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
    console.log('Old hash:', adminUser.hash)

    // Generate bcrypt hash
    const hash = await bcrypt.hash(NEW_PASSWORD, 10)
    const salt = hash.substring(0, 29)

    console.log('\nNew salt:', salt)
    console.log('New hash:', hash)

    // Update the hash column only (salt might not be used)
    await pool.query(
      `UPDATE users SET hash = $1, salt = $2 WHERE id = $3`,
      [hash, salt, adminUser.id]
    )

    // Verify by reading back and testing
    const updated = await pool.query(
      `SELECT hash FROM users WHERE id = $1`,
      [adminUser.id]
    )

    const storedHash = updated.rows[0].hash
    console.log('\nStored hash:', storedHash)

    // Test if password verification works
    const isValid = await bcrypt.compare(NEW_PASSWORD, storedHash)
    console.log('Password verification test:', isValid ? 'PASSED' : 'FAILED')

    if (isValid) {
      console.log('\n✓ Password reset successfully!')
      console.log('Email:', adminUser.email)
      console.log('Password:', NEW_PASSWORD)
      console.log('\n>>> RESTART PM2: pm2 restart all <<<')
    } else {
      console.log('\n✗ Password verification failed!')
    }
  } catch (error) {
    console.error('Error:', error)
    process.exit(1)
  } finally {
    await pool.end()
  }
}

resetPassword()

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

    // Generate bcrypt hash
    const hash = await bcrypt.hash(NEW_PASSWORD, 10)
    const salt = hash.substring(0, 29)

    // Update hash AND clear lock
    await pool.query(
      `UPDATE users
       SET hash = $1, salt = $2, login_attempts = 0, lock_until = NULL
       WHERE id = $3`,
      [hash, salt, adminUser.id]
    )

    // Verify
    const updated = await pool.query(
      `SELECT hash, login_attempts, lock_until FROM users WHERE id = $1`,
      [adminUser.id]
    )

    const row = updated.rows[0]
    const isValid = await bcrypt.compare(NEW_PASSWORD, row.hash)

    console.log('Password verification:', isValid ? 'PASSED' : 'FAILED')
    console.log('Login attempts reset:', row.login_attempts === 0 ? 'YES' : 'NO')
    console.log('Lock cleared:', row.lock_until === null ? 'YES' : 'NO')

    if (isValid) {
      console.log('\n✓ Password reset and account unlocked!')
      console.log('Email:', adminUser.email)
      console.log('Password:', NEW_PASSWORD)
    }
  } catch (error) {
    console.error('Error:', error)
    process.exit(1)
  } finally {
    await pool.end()
  }
}

resetPassword()

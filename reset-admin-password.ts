import 'dotenv/config'
import pg from 'pg'
import bcrypt from 'bcryptjs'

const NEW_PASSWORD = 'Admin@123!'

async function resetPassword() {
  const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
  })

  try {
    // Find admin users
    const admins = await pool.query(
      `SELECT id, email, role FROM users WHERE role = 'admin'`
    )

    console.log(`Found ${admins.rowCount} admin users:`)
    admins.rows.forEach((u: any) => {
      console.log(`  - ID: ${u.id}, Email: ${u.email}`)
    })

    if (admins.rowCount === 0) {
      console.log('No admin users found!')
      process.exit(1)
    }

    const adminUser = admins.rows[0]
    console.log(`\nResetting password for: ${adminUser.email} (ID: ${adminUser.id})`)

    // Generate salt and hash using bcrypt (Payload's default)
    const salt = await bcrypt.genSalt(10)
    const hash = await bcrypt.hash(NEW_PASSWORD, salt)

    // Update salt and hash directly in database
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

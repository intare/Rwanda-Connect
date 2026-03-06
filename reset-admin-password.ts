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

    // Check table columns
    const columns = await pool.query(`
      SELECT column_name FROM information_schema.columns
      WHERE table_name = 'users'
      ORDER BY ordinal_position
    `)
    console.log('\nUsers table columns:', columns.rows.map((r: any) => r.column_name).join(', '))

    const adminUser = admins.rows[0]
    console.log(`\nResetting password for: ${adminUser.email} (ID: ${adminUser.id})`)

    // Hash the new password using bcrypt (Payload's default)
    const hashedPassword = await bcrypt.hash(NEW_PASSWORD, 10)

    // Update password directly in database
    const result = await pool.query(
      `UPDATE users SET password = $1 WHERE id = $2 RETURNING id, email`,
      [hashedPassword, adminUser.id]
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

import 'dotenv/config'
import pg from 'pg'

async function fixAdminRole() {
  const pool = new pg.Pool({
    connectionString: process.env.DATABASE_URL,
  })

  try {
    // Check current status
    const users = await pool.query(
      `SELECT id, email, role, contributor_status FROM users WHERE email = 'newadmin@rwandaconnect.com'`
    )

    if (users.rowCount === 0) {
      console.log('User not found!')
      process.exit(1)
    }

    console.log('Current user status:')
    console.log(users.rows[0])

    // Fix role and contributor status
    await pool.query(
      `UPDATE users
       SET role = 'admin', contributor_status = 'approved'
       WHERE email = 'newadmin@rwandaconnect.com'`
    )

    // Verify
    const updated = await pool.query(
      `SELECT id, email, role, contributor_status FROM users WHERE email = 'newadmin@rwandaconnect.com'`
    )

    console.log('\nUpdated user status:')
    console.log(updated.rows[0])

    console.log('\n✓ Admin role and contributor status fixed!')
    console.log('Please log out and log back in for changes to take effect.')

  } catch (error) {
    console.error('Error:', error)
  } finally {
    await pool.end()
  }
}

fixAdminRole()

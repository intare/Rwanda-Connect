import postgres from 'postgres';

const sql = postgres('postgresql://postgres:root@localhost:5432/rwanda_connect');

async function resetDatabase() {
  try {
    console.log('Dropping all tables...');

    // Get all tables and drop them
    const tables = await sql`
      SELECT tablename FROM pg_tables WHERE schemaname = 'public'
    `;

    for (const { tablename } of tables) {
      console.log(`Dropping table: ${tablename}`);
      await sql.unsafe(`DROP TABLE IF EXISTS "${tablename}" CASCADE`);
    }

    // Drop all enums
    const enums = await sql`
      SELECT typname FROM pg_type
      WHERE typtype = 'e'
      AND typnamespace = (SELECT oid FROM pg_namespace WHERE nspname = 'public')
    `;

    for (const { typname } of enums) {
      console.log(`Dropping enum: ${typname}`);
      await sql.unsafe(`DROP TYPE IF EXISTS "${typname}" CASCADE`);
    }

    console.log('\nDatabase reset complete!');
    console.log('Run "pnpm dev" to recreate tables with richText fields.');

  } catch (err) {
    console.error('Error:', err.message);
  } finally {
    await sql.end();
  }
}

resetDatabase();

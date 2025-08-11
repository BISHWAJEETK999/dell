import { drizzle } from 'drizzle-orm/neon-http';
import { neon } from '@neondatabase/serverless';
import * as schema from "@shared/schema";

let db: any;
let pool: any;

// Check if DATABASE_URL is available and accessible
if (process.env.DATABASE_URL) {
  try {
    // Use PostgreSQL database when available
    console.log("Attempting to connect to PostgreSQL database...");
    const sql = neon(process.env.DATABASE_URL);
    db = drizzle(sql, { schema });
    pool = sql;
    console.log("✓ PostgreSQL database connection configured");
  } catch (error) {
    console.log("⚠️ PostgreSQL connection failed, falling back to in-memory storage");
    console.log("Database connection error:", error instanceof Error ? error.message : String(error));
    db = null;
    pool = null;
  }
} else {
  // Development environment - use in-memory storage
  console.log("Using in-memory storage for development environment");
  db = null;
  pool = null;
}

export { db, pool };

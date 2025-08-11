import { drizzle } from 'drizzle-orm/neon-http';
import { neon } from '@neondatabase/serverless';
import * as schema from "@shared/schema";

let db: any;
let pool: any;

// Check if DATABASE_URL is available
if (process.env.DATABASE_URL) {
  // Use PostgreSQL database when available
  console.log("Using PostgreSQL database for production environment");
  const sql = neon(process.env.DATABASE_URL);
  db = drizzle(sql, { schema });
  pool = sql;
} else {
  // Development environment - use in-memory storage
  console.log("Using in-memory storage for development environment");
  db = null;
  pool = null;
}

export { db, pool };

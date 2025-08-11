# Neon Database Setup Guide

## Simple Process for Neon SQL Database

### Step 1: Get Your Neon Database URL
1. Go to [neon.tech](https://neon.tech)
2. Sign up or log in to your account
3. Create a new project or use existing one
4. Copy your connection string (looks like: `postgresql://username:password@hostname/database`)

### Step 2: Update Database URL in Replit
1. In Replit, go to Secrets tab (lock icon in sidebar)
2. Find the existing `DATABASE_URL` secret
3. Replace the value with your Neon database URL
4. Save the changes

### Step 3: Restart Application
The application will automatically connect to your Neon database and initialize the schema.

### Step 4: Initialize Database (One-time)
After connecting, run the database initialization to create tables and add sample data.

## Benefits of Neon vs Render Database
✅ **Accessible from Replit** - No network restrictions
✅ **Persistent data** - Your data survives across deployments
✅ **Better development** - Same database for dev and production
✅ **Free tier available** - Cost-effective for development

## Expected Behavior After Setup
- Application will use PostgreSQL instead of in-memory storage
- All your data will be persistent
- Admin login will work with database-stored credentials
- Gallery, destinations, and content will be saved permanently
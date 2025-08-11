# TTravel Hospitality - Render Deployment Guide

## Complete Step-by-Step Deployment Process

### Prerequisites
1. GitHub account with your project repository
2. Render account (free at render.com)
3. Your project code ready for deployment

### Step 1: Prepare Your Project for Render

Your project is now fully configured for Render deployment with these files:
- `render.yaml` - Render service configuration
- `Dockerfile` - Container configuration (optional)
- `.env.example` - Environment variables template
- `migrations/0000_initial_schema.sql` - Database setup script

### Step 2: Push Your Code to GitHub

1. Create a new repository on GitHub
2. Push your project code:
```bash
git init
git add .
git commit -m "Initial commit - TTravel Hospitality"
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
git push -u origin main
```

### Step 3: Create Database on Render

1. Go to https://dashboard.render.com
2. Click "New" → "PostgreSQL"
3. Configure:
   - **Name**: `ttravel-db`
   - **Database**: `ttravel_hospitality`
   - **User**: `ttravel_user`
   - **Plan**: Free (or paid as needed)
4. Click "Create Database"
5. **IMPORTANT**: Save the connection details:
   - Internal Database URL
   - External Database URL
   - Username/Password

### Step 4: Initialize Database Schema

**IMPORTANT**: You need to run this on your Render database directly since the connection from Replit may not work due to network restrictions.

**Method 1: Using Render Web Shell (Recommended)**
1. Go to your Render database dashboard
2. Click "Connect" → "Web Shell"
3. Copy and paste the SQL commands from `migrations/0000_initial_schema.sql`
4. Run each section separately to ensure they execute properly

**Method 2: Using local PostgreSQL client**
```bash
psql "YOUR_EXTERNAL_DATABASE_URL" < migrations/0000_initial_schema.sql
```

**Method 3: Using any PostgreSQL client**
- Use the external connection string with pgAdmin, DBeaver, or similar
- Import and run the migration file

### Step 5: Deploy Web Service

1. In Render Dashboard, click "New" → "Web Service"
2. Connect your GitHub repository
3. Configure the web service:
   - **Name**: `ttravel-hospitality`
   - **Environment**: `Node`
   - **Build Command**: `npm install && npm run build`
   - **Start Command**: `npm start`
   - **Plan**: Free (or paid as needed)

### Step 6: Configure Environment Variables

Add these environment variables in your web service settings:

```
NODE_ENV=production
SESSION_SECRET=your-random-secret-key-here-make-it-long-and-secure
DATABASE_URL=YOUR_INTERNAL_DATABASE_URL_FROM_STEP_3
PORT=10000
```

**Important Notes:**
- Use the **Internal Database URL** for DATABASE_URL (faster connection)
- Generate a secure SESSION_SECRET (random string, at least 32 characters)
- PORT=10000 is required by Render

### Step 7: Deploy and Test

1. Click "Deploy Latest Commit"
2. Monitor the build logs for any errors
3. Once deployed, test your application:
   - Visit your Render app URL
   - Test the home page
   - Test admin login (username: admin, password: 8709612003)
   - Test contact form submission
   - Test navigation between pages

### Step 8: Admin Setup

1. Access your admin panel: `https://your-app.onrender.com/admin`
2. Login with: username `admin`, password `8709612003`
3. **IMMEDIATELY** change the admin password in Settings
4. Update content, add destinations, manage packages as needed

### Step 9: Custom Domain (Optional)

1. In your web service settings, go to "Settings"
2. Scroll to "Custom Domain"
3. Add your domain and follow DNS configuration instructions

## Environment Variables Explained

- **DATABASE_URL**: Connection string to your PostgreSQL database
- **SESSION_SECRET**: Secret key for session encryption (generate a random string)
- **NODE_ENV**: Set to 'production' for optimal performance
- **PORT**: Port number (10000 for Render)

## Database Schema

Your database includes these tables:
- `users` - Admin authentication
- `content` - Dynamic website content
- `destinations` - Travel destinations
- `packages` - Travel packages
- `contact_submissions` - Contact form data
- `newsletter_subscriptions` - Email subscriptions
- `gallery_images` - Image gallery

## Security Features

✅ Secure session configuration for production
✅ Environment-based database connections
✅ Input validation with Zod schemas
✅ SQL injection protection with Drizzle ORM
✅ Session-based admin authentication
✅ Secure cookie configuration

## Troubleshooting

**Build Errors:**
- Check that all dependencies are in package.json
- Verify Node.js version compatibility

**Database Connection Issues:**
- Verify DATABASE_URL is correct (use internal URL)
- Check database is running and accessible
- Verify database schema was created

**App Not Loading:**
- Check environment variables are set correctly
- Verify PORT=10000
- Check build logs for errors

**Admin Login Issues:**
- Verify database connection
- Check if users table was created with initial admin user
- Default login: admin / 8709612003

## Support

For deployment issues:
1. Check Render build logs
2. Verify all environment variables
3. Test database connection
4. Check that all required files are in your repository

Your TTravel Hospitality app is now ready for production on Render!
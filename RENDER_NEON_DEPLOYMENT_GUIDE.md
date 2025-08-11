# Render + Neon SQL Deployment Guide

## Complete Setup Process

### Step 1: Setup Neon Database
1. Go to [neon.tech](https://neon.tech)
2. Create account and new project
3. Copy your connection string (format: `postgresql://user:pass@hostname.neon.tech/database`)

### Step 2: Configure Render Service
1. Go to your Render dashboard
2. Create new Web Service from your GitHub repository
3. Configure these settings:

**Build Settings:**
- Build Command: `./build.sh`
- Start Command: `npm start`

**Environment Variables:**
- `NODE_ENV`: `production`
- `SESSION_SECRET`: (generate random string)
- `DATABASE_URL`: (your Neon connection string)

### Step 3: Deploy to Render
1. Connect your GitHub repository
2. Trigger deployment
3. Render will automatically build and deploy your application

### Step 4: Initialize Database (One-time)
After first successful deployment:
1. Go to Render service logs
2. The application will automatically create database tables
3. Admin user will be created with password: `8709612003`

## Benefits of This Setup
✅ **Render Hosting** - Reliable web hosting with automatic deployments
✅ **Neon Database** - Serverless PostgreSQL with excellent performance
✅ **Cost Effective** - Both services offer generous free tiers
✅ **Scalable** - Easy to upgrade as your application grows
✅ **No Render Database** - Using Neon eliminates Render database costs

## Expected Results
- Your travel website will be live on Render
- All data stored persistently in Neon database
- Admin panel accessible for content management
- Gallery, destinations, and bookings all working
- Automatic builds when you push code changes

## Configuration Files Updated
- `render.yaml` - Updated to use Neon instead of Render database
- `build.sh` - Robust build script for reliable deployments
- Database connection - Configured for Neon compatibility

## Next Steps
1. Get your Neon database URL
2. Update the DATABASE_URL in render.yaml
3. Push changes to GitHub
4. Deploy on Render
# Split Deployment Guide: Vercel + Render + Neon

## Architecture Overview
✅ **Frontend** → Vercel (public link)  
✅ **Backend API** → Render (hosted link)  
✅ **Database** → Neon  
✅ **Admin Panel** → `/admin` on your frontend  

## Step-by-Step Deployment Process

### 1. Setup Neon Database (2 minutes)
1. Go to [neon.tech](https://neon.tech) → Create account
2. Create new project → Get connection string
3. Save it: `postgresql://user:pass@hostname.neon.tech/database`

### 2. Deploy Backend to Render (5 minutes)
1. Go to [render.com](https://render.com) → New Web Service
2. Connect your GitHub repository
3. Configure:
   - **Build Command**: `./build-backend.sh`
   - **Start Command**: `node dist/index.js`
   - **Environment Variables**:
     - `NODE_ENV`: `production`
     - `DATABASE_URL`: (your Neon connection string)
     - `SESSION_SECRET`: (random string)
4. Deploy → Get your backend URL: `https://your-app.onrender.com`

### 3. Deploy Frontend to Vercel (3 minutes)
1. Go to [vercel.com](https://vercel.com) → New Project
2. Import from GitHub
3. Configure:
   - **Framework**: Vite
   - **Root Directory**: `client`
   - **Environment Variable**: 
     - `VITE_API_URL`: `https://your-render-backend.onrender.com`
4. Deploy → Get your frontend URL: `https://your-app.vercel.app`

### 4. Update CORS Settings (1 minute)
Update the `CORS_ORIGIN` environment variable in Render:
- `CORS_ORIGIN`: `https://your-vercel-frontend.vercel.app`

## What You'll Have
- **Public Website**: `https://your-app.vercel.app`
- **Admin Panel**: `https://your-app.vercel.app/admin`
- **API Endpoint**: `https://your-backend.onrender.com/api`
- **Database**: Managed by Neon

## Benefits of This Setup
✅ **Fast Frontend** - Vercel's edge network for optimal performance  
✅ **Reliable Backend** - Render for API hosting with automatic scaling  
✅ **Persistent Database** - Neon for reliable PostgreSQL storage  
✅ **Cost Effective** - All services offer generous free tiers  
✅ **Easy Updates** - Push to GitHub → automatic deployments  

## Files Created/Updated
- `vercel.json` - Vercel deployment configuration
- `render.yaml` - Render backend deployment  
- `build-backend.sh` - Backend build script
- `client/package.json` - Frontend dependencies

## Admin Access
- URL: `https://your-frontend.vercel.app/admin`
- Username: `admin`
- Password: `8709612003`

Ready to deploy! Just provide your Neon database URL and I'll complete the configuration.
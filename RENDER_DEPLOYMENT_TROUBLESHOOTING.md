# Render Deployment Troubleshooting Guide

## Current Issue
Render deployment is failing with "vite: not found" error during the build process.

## Root Cause Analysis
The issue occurs because:
1. Render may not be installing devDependencies properly
2. The `vite` and `esbuild` commands are not accessible in the PATH during build
3. The build process expects these tools to be globally available

## Solutions Applied

### Solution 1: Updated render.yaml
```yaml
buildCommand: npm install --include=dev && npm run build
```
This ensures devDependencies are installed explicitly.

### Solution 2: Custom Build Script (build.sh)
Created a robust build script that:
- Installs all dependencies including dev dependencies
- Uses `npx` to run build tools (ensures they're found)
- Provides fallback mechanisms if primary build fails
- Gives detailed logging for troubleshooting

### Solution 3: Alternative render.yaml with Custom Script
```yaml
buildCommand: ./build.sh
```

## Manual Steps for User

If the automated fixes don't work, try these manual approaches in your Render dashboard:

### Option A: Move Build Tools to Dependencies
In package.json, move these from devDependencies to dependencies:
```json
{
  "dependencies": {
    "vite": "^5.4.19",
    "esbuild": "^0.25.8",
    "@vitejs/plugin-react": "^4.7.0"
  }
}
```

### Option B: Simplified Build Command
Use this build command in Render dashboard:
```bash
npm install && npx vite build && npx esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist
```

### Option C: Environment Variables
Add these environment variables in Render:
- `NPM_CONFIG_INCLUDE`: `dev`
- `NODE_ENV`: `production`

## Testing the Fix
1. Commit the changes to your repository
2. Trigger a new deployment in Render
3. Check the build logs for success
4. Verify the application starts correctly

## Expected Outcome
With these fixes, the Render deployment should:
1. Successfully install all dependencies
2. Build the frontend with Vite
3. Bundle the backend with ESBuild
4. Start the application without errors

The application will be available at your Render URL once deployment completes successfully.
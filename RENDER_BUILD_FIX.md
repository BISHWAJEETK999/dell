# Render Deployment Build Fix

## Issue
The Render deployment is failing because `vite` command is not found during the build process.

## Root Cause
Render was not installing devDependencies properly, which meant `vite` and `esbuild` were not available during the build.

## Solution Applied
1. Updated `render.yaml` to use `npm ci` instead of `npm install` for more reliable dependency installation
2. The `npm ci` command installs all dependencies (including devDependencies) based on the exact versions in package-lock.json

## Additional Recommendations for User

If the build still fails on Render, try these steps:

### Option 1: Move Build Dependencies to Production Dependencies
Move these packages from devDependencies to dependencies in package.json:
- `vite`
- `esbuild`
- `@vitejs/plugin-react`

### Option 2: Modify Render Build Command
In your Render dashboard, update the build command to:
```
npm install --include=dev && npm run build
```

### Option 3: Use Alternative Build Approach
Create a separate build script that uses npx:
```
npx vite build && npx esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist
```

## Current render.yaml Configuration
```yaml
buildCommand: npm ci && npm run build
```

This should resolve the "vite: not found" error during Render deployment.
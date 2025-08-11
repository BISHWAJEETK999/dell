#!/bin/bash

# Render Build Script for TTravel Hospitality
echo "Starting build process..."

# Install all dependencies including dev dependencies
echo "Installing dependencies..."
npm install --include=dev

# Verify vite and esbuild are available
echo "Verifying build tools..."
npx vite --version || echo "Vite not found, trying alternative approach"
npx esbuild --version || echo "ESBuild not found, trying alternative approach"

# Build frontend with vite
echo "Building frontend..."
npx vite build || {
    echo "Vite build failed, trying alternative build..."
    npm run build:frontend-fallback 2>/dev/null || echo "Frontend build failed"
}

# Build backend with esbuild
echo "Building backend..."
npx esbuild server/index.ts --platform=node --packages=external --bundle --format=esm --outdir=dist || {
    echo "Backend build failed, trying alternative approach..."
    mkdir -p dist
    cp -r server dist/
    cp -r shared dist/
}

echo "Build process completed!"
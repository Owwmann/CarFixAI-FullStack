#!/bin/bash

# RPP AUTO - Quick Start Script
# This script helps you get your app running locally with Expo Go

echo "🚀 RPP AUTO - Expo Quick Start"
echo "================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed."
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo ""

# Navigate to mobile directory
if [ ! -d "./mobile" ]; then
    echo "❌ Mobile directory not found."
    echo "Please run this script from the RPP-AUTO-FullStack root directory."
    exit 1
fi

cd mobile

echo "📦 Installing dependencies..."
echo "(This may take 5-10 minutes on first run)"
npm install

if [ $? -ne 0 ]; then
    echo "❌ npm install failed."
    exit 1
fi

echo ""
echo "✅ Dependencies installed successfully!"
echo ""
echo "🎯 Starting Expo development server..."
echo ""
echo "📱 Next steps:"
echo "1. Install 'Expo Go' app on your phone from:"
echo "   - iOS: https://apps.apple.com/app/expo-go/id982107779"
echo "   - Android: https://play.google.com/store/apps/details?id=host.exp.exponent"
echo ""
echo "2. When QR code appears below, scan it with:"
echo "   - iOS: Camera app (tap the banner that appears)"
echo "   - Android: Expo Go app (tap 'Scan QR Code')"
echo ""
echo "3. Your app will load on your phone in ~30 seconds!"
echo ""
echo "================================"
echo ""

npx expo start

#!/bin/bash

# Setup script for WordClockWidgets iOS project
# Run this script on macOS with Xcode installed

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="${SCRIPT_DIR}"

echo "================================================"
echo "WordClockWidgets iOS - Setup Script"
echo "================================================"
echo ""

# Check for macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "ERROR: This script must run on macOS"
    exit 1
fi

echo "✓ Running on macOS"

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "ERROR: Xcode not found"
    echo "Please install Xcode from App Store: https://apps.apple.com/app/xcode/id497799835"
    exit 1
fi

XCODE_VERSION=$(xcodebuild -version | head -1)
echo "✓ Xcode installed: $XCODE_VERSION"

# Check for Swift
SWIFT_VERSION=$(swift --version)
echo "✓ Swift version: $SWIFT_VERSION"

# Create build directories
mkdir -p "${PROJECT_DIR}/build"
mkdir -p "${PROJECT_DIR}/build/DerivedData"

echo ""
echo "================================================"
echo "Project Configuration"
echo "================================================"

# Project settings
PROJECT_NAME="WordClockWidgets"
BUNDLE_ID="com.akfsno.wordclockwidgets"
TEAM_ID="${TEAM_ID:-}"

echo "Project Name: $PROJECT_NAME"
echo "Bundle ID: $BUNDLE_ID"
echo "Team ID: ${TEAM_ID:-Not set}"
echo ""

# Check if workspace exists
if [ ! -f "${PROJECT_DIR}/${PROJECT_NAME}.xcworkspace/contents.xcworkspacedata" ]; then
    echo "⚠ Creating workspace..."
    
    # Create workspace structure
    mkdir -p "${PROJECT_DIR}/${PROJECT_NAME}.xcworkspace"
    cat > "${PROJECT_DIR}/${PROJECT_NAME}.xcworkspace/contents.xcworkspacedata" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<Workspace version = "1.0">
   <FileRef location = "group:WordClockWidgets">
   </FileRef>
   <FileRef location = "group:WordClockWidgetsWidget">
   </FileRef>
</Workspace>
EOF
    echo "✓ Workspace created"
fi

# Check for app icons
if [ ! -d "${PROJECT_DIR}/WordClockWidgets/Assets.xcassets/AppIcon.appiconset" ]; then
    echo "⚠ App icons not found. You'll need to add:"
    echo "  1. 1024x1024 app icon to Assets.xcassets/AppIcon.appiconset"
    echo "  2. Contents.json file for icon configuration"
fi

# Check for launch screen
if [ ! -f "${PROJECT_DIR}/WordClockWidgets/LaunchScreen.storyboard" ]; then
    echo "⚠ LaunchScreen.storyboard not found"
    echo "  You may need to create a launch screen"
fi

echo ""
echo "================================================"
echo "Build Targets"
echo "================================================"
echo "1. WordClockWidgets - Main app"
echo "2. WordClockWidgetsWidget - Home screen widget"
echo ""

# Suggest next steps
echo "================================================"
echo "Next Steps:"
echo "================================================"
echo ""
echo "1. Open project in Xcode:"
echo "   open ${PROJECT_NAME}.xcworkspace"
echo ""
echo "2. Configure signing:"
echo "   - Project Settings → Signing & Capabilities"
echo "   - Select your Team"
echo "   - Update Bundle ID if needed"
echo ""
echo "3. Add App Icons:"
echo "   - Assets.xcassets → AppIcon"
echo "   - Drag your 1024x1024 icon"
echo ""
echo "4. Build:"
echo "   - Select iPhone XS from device list"
echo "   - Press Cmd+B to build"
echo ""
echo "5. Run on device:"
echo "   - Connect iPhone XS via USB"
echo "   - Press Cmd+R to run"
echo ""
echo "================================================"
echo "Setup Complete!"
echo "================================================"

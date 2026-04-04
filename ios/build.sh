#!/bin/bash

# Build configuration script for WordClockWidgets iOS project
# This script prepares the project for Xcode compilation on macOS

set -e

echo "==== WordClockWidgets iOS Build Configuration ===="
echo "Platform: iOS 18.4.1+"
echo "Device: iPhone XS"
echo "Swift Version: 5.9+"

# Check for Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "ERROR: Xcode is not installed or not in PATH"
    echo "Please install Xcode from App Store or visit https://developer.apple.com/download/"
    exit 1
fi

echo "✓ Xcode found: $(xcodebuild -version)"

# Get Xcode path
XCODE_PATH=$(xcode-select -p)
echo "✓ Xcode path: $XCODE_PATH"

# Project settings
PROJECT_NAME="WordClockWidgets"
WORKSPACE_NAME="${PROJECT_NAME}.xcworkspace"
BUILD_DIR="./build"
DERIVED_DATA_PATH="${BUILD_DIR}/DerivedData"

echo ""
echo "==== Build Settings ===="
echo "Project: $PROJECT_NAME"
echo "Workspace: $WORKSPACE_NAME"
echo "Build Directory: $BUILD_DIR"
echo "Derived Data: $DERIVED_DATA_PATH"

# Create build directory if it doesn't exist
mkdir -p "$BUILD_DIR"

echo ""
echo "==== Ready for build ===="
echo "To build with Xcode:"
echo "  1. Open $WORKSPACE_NAME in Xcode"
echo "  2. Select iPhone XS simulator or device"
echo "  3. Press Cmd+B to build"
echo ""
echo "Or use xcodebuild from command line:"
echo "  xcodebuild -workspace $WORKSPACE_NAME -scheme $PROJECT_NAME -configuration Release -derivedDataPath $DERIVED_DATA_PATH"

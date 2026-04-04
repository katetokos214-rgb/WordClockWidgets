#!/bin/bash

# Deployment script for WordClockWidgets iOS
# This script validates and prepares the project for deployment

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="${SCRIPT_DIR}"

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║   WordClockWidgets iOS - Deployment Validator         ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Check macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ This script must run on macOS"
    echo "   Current OS: $OSTYPE"
    exit 1
fi

echo "✓ macOS detected"

# Check Xcode
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode not found"
    echo "   Please install Xcode: https://apps.apple.com/app/xcode/id497799835"
    exit 1
fi

XCODE_VERSION=$(xcodebuild -version | head -1)
echo "✓ Xcode: $XCODE_VERSION"

# Check Swift
if ! command -v swift &> /dev/null; then
    echo "❌ Swift not found"
    exit 1
fi

SWIFT_VERSION=$(swift --version)
echo "✓ $SWIFT_VERSION"

# Check file structure
echo ""
echo "Checking project structure..."

FILES=(
    "WordClockWidgets/AppDelegate.swift"
    "WordClockWidgets/SceneDelegate.swift"
    "WordClockWidgets/ViewController.swift"
    "WordClockWidgets/NumberToWords.swift"
    "WordClockWidgets/WidgetPreferences.swift"
    "WordClockWidgets/CompatibilityChecker.swift"
    "WordClockWidgets/Info.plist"
    "WordClockWidgetsWidget/WordClockWidgetsWidget.swift"
    "WordClockWidgetsWidget/Info.plist"
    "Package.swift"
    "README.md"
    "BUILD_GUIDE.md"
    "DEVICE_INSTALLATION.md"
)

MISSING=0
for file in "${FILES[@]}"; do
    if [ -f "${PROJECT_DIR}/${file}" ]; then
        echo "  ✓ ${file}"
    else
        echo "  ⚠ ${file} (missing)"
        MISSING=$((MISSING + 1))
    fi
done

echo ""
echo "════════════════════════════════════════════════════════"
echo "Project Summary"
echo "════════════════════════════════════════════════════════"
echo ""
echo "Target Device:     iPhone XS"
echo "iOS Version:       iOS 18.4.1+"
echo "Minimum iOS:       iOS 14.0"
echo "Language:          Swift 5.9+"
echo "Main Framework:    SwiftUI + WidgetKit"
echo "Deployment:        Device & Simulator"
echo ""

# Count Swift files
SWIFT_COUNT=$(find "${PROJECT_DIR}" -name "*.swift" | wc -l)
echo "Swift files:       $SWIFT_COUNT"

# Check for workspace
if [ -d "${PROJECT_DIR}/${PROJECT_DIR##*/}.xcworkspace" ]; then
    echo "Workspace:         ✓ Found"
else
    echo "Workspace:         ⚠ Not found (will be created by Xcode)"
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo "Build Instructions"
echo "════════════════════════════════════════════════════════"
echo ""
echo "1. Open in Xcode:"
echo "   cd ${PROJECT_DIR}"
echo "   open WordClockWidgets.xcworkspace"
echo ""
echo "2. For iPhone XS Simulator:"
echo "   - Select 'iPhone XS' from device menu"
echo "   - Press Cmd+B to build"
echo "   - Press Cmd+R to run"
echo ""
echo "3. For Physical iPhone XS:"
echo "   - Connect device via USB"
echo "   - Select your iPhone XS from device menu"
echo "   - Press Cmd+B to build"
echo "   - Press Cmd+R to install and run"
echo ""
echo "4. Command line build (Debug):"
echo "   xcodebuild -workspace WordClockWidgets.xcworkspace \\"
echo "     -scheme WordClockWidgets \\"
echo "     -configuration Debug \\"
echo "     -derivedDataPath ./build/DerivedData"
echo ""
echo "5. Command line build (Release):"
echo "   xcodebuild -workspace WordClockWidgets.xcworkspace \\"
echo "     -scheme WordClockWidgets \\"
echo "     -configuration Release \\"
echo "     -derivedDataPath ./build/DerivedData"
echo ""

echo "════════════════════════════════════════════════════════"
echo "Next Steps"
echo "════════════════════════════════════════════════════════"
echo ""

if [ $MISSING -eq 0 ]; then
    echo "✅ All required files are present!"
    echo ""
    echo "Ready to deploy. Follow these steps:"
    echo ""
    echo "1. For Simulator:"
    echo "   $ open WordClockWidgets.xcworkspace"
    echo "   [In Xcode] Select iPhone XS simulator → Cmd+R"
    echo ""
    echo "2. For Device:"
    echo "   $ open WordClockWidgets.xcworkspace"
    echo "   [In Xcode] Connect iPhone XS → Select device → Cmd+B → Cmd+R"
    echo ""
    echo "3. For Documentation:"
    echo "   - Read BUILD_GUIDE.md for build options"
    echo "   - Read DEVICE_INSTALLATION.md for device setup"
    echo ""
else
    echo "⚠ Warning: $MISSING file(s) missing. See above for details."
    echo ""
    echo "This may prevent successful compilation."
    echo "Please ensure all files are in place before building."
fi

echo ""
echo "════════════════════════════════════════════════════════"
echo "Validation Complete"
echo "════════════════════════════════════════════════════════"

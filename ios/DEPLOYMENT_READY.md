# iOS Deployment - README

## Project Status: ✅ READY FOR BUILD

This iOS project is fully configured and ready to be compiled and installed on iPhone XS with iOS 18.4.1.

## Quick Start

### On macOS with Xcode:

```bash
# Navigate to iOS project directory
cd ios/

# Make deployment scripts executable
chmod +x setup.sh deploy.sh build.sh

# Run validation
./deploy.sh

# Open in Xcode
open WordClockWidgets.xcworkspace
```

Then in Xcode:
1. Select iPhone XS simulator or device
2. Press `Cmd+B` to build
3. Press `Cmd+R` to run

## Project Structure

```
ios/
├── WordClockWidgets/              # Main Application
│   ├── AppDelegate.swift          # App entry point
│   ├── SceneDelegate.swift        # Scene management
│   ├── ViewController.swift       # Configuration UI
│   ├── NumberToWords.swift        # Russian text conversion
│   ├── WidgetPreferences.swift    # Settings storage
│   ├── CompatibilityChecker.swift # iOS 18.4.1 validation
│   ├── Info.plist                 # App configuration
│   └── Resources/                 # Assets (placeholder)
│
├── WordClockWidgetsWidget/        # Home Screen Widget
│   ├── WordClockWidgetsWidget.swift
│   └── Info.plist
│
├── Package.swift                  # Swift Package manifest
├── project.pbxproj               # Xcode project structure
├── WordClockWidgets.xcworkspace/ # Xcode workspace (auto-created)
│
├── setup.sh                       # Initial setup script
├── deploy.sh                      # Deployment validator
├── build.sh                       # Build helper script
│
└── Documentation:
    ├── README.md                  # This file
    ├── BUILD_GUIDE.md             # Build instructions
    ├── DEVICE_INSTALLATION.md     # iPhone XS setup guide
    └── iOS_COMPATIBILITY.md       # Features & compatibility
```

## Requirements

### Minimum
- macOS 13.0 or later
- Xcode 15.0 or later
- Swift 5.9+

### For Device Installation
- iPhone XS with iOS 14.0+ (tested on iOS 18.4.1)
- USB lightning cable
- Apple ID (for code signing)

## Build Options

### Debug Build (for development)
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Debug \
  -destination 'generic/platform=ios' \
  -derivedDataPath ./build/DerivedData
```

### Release Build (for distribution)
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Release \
  -destination 'generic/platform=ios' \
  -derivedDataPath ./build/DerivedData
```

### For iPhone XS Simulator
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Release \
  -destination 'platform=iOS Simulator,name=iPhone XS' \
  -derivedDataPath ./build/DerivedData
```

## Features

✅ **Time Display in Russian Words**
  - Hour, minute, day/night indicator
  - Date and day of week (optional)
  - Automatic language support

✅ **Home Screen Widget**
  - Small, medium, large sizes
  - Automatic time updates
  - Customizable layout positions

✅ **Settings & Preferences**
  - Toggle display elements
  - Adjust colors and borders
  - Move elements with joystick

✅ **iOS 18.4.1 Optimization**
  - WidgetKit support
  - SwiftUI framework
  - Modern development patterns

## Compatibility

| Feature | Support |
|---------|---------|
| iOS Version | 14.0+ (optimized for 18.4.1) |
| Devices | iPhone XS and newer |
| WidgetKit | ✅ Full support |
| SwiftUI | ✅ Full support |
| Dark Mode | ✅ Supported |
| Localization | 🇷🇺 Russian optimized |

## Verification Checklist

Before building:
- [ ] Swift version 5.9+ installed
- [ ] Xcode 15.0+ installed
- [ ] All .swift files present (6 main files)
- [ ] Info.plist files configured
- [ ] Package.swift manifest exists

After building:
- [ ] No compilation errors
- [ ] No warnings in build log
- [ ] App launches on simulator
- [ ] Widget displays time correctly
- [ ] Configuration UI responsive

## Apple Developer Setup

For installing on physical device:

1. **Free Account:**
   - Go to https://developer.apple.com/
   - Create Apple ID if needed
   - Enroll in Apple Developer Program

2. **Provisioning:**
   - Register your iPhone XS UDID
   - Create App ID: `com.akfsno.wordclockwidgets`
   - Generate provisioning profile
   - Download and install certificate

3. **Code Signing:**
   - Open Xcode Preferences → Accounts
   - Add your Apple ID
   - Project → Signing & Capabilities
   - Select team and verify bundle ID

## Troubleshooting

### Build Fails
1. Delete derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/`
2. Clean build: `Cmd+Shift+K`
3. Rebuild: `Cmd+B`

### Device Connection Issues
1. Disconnect USB and reconnect
2. In Xcode: Devices and Simulators → Disconnect → Reconnect
3. Restart iPhone XS
4. Restart Xcode if needed

### Code Signature Errors
1. Verify Apple ID is signed into Xcode
2. Update provisioning profile in Xcode preferences
3. Delete app from device
4. Rebuild and reinstall

## Installation on iPhone XS

### Via Xcode (Recommended)
1. Connect iPhone XS via USB
2. Unlock and tap "Trust"
3. Select device in Xcode toolbar
4. Press `Cmd+R` to install and run

### Via TestFlight (for distribution)
1. Requires paid Apple Developer account
2. Archive app in Xcode
3. Upload to App Store Connect
4. Share TestFlight link with testers

## Version Information

- **App Version:** 1.0
- **Build Version:** 1
- **Min OS:** iOS 14.0
- **Target OS:** iOS 18.4.1+
- **Swift:** 5.9+
- **Deployment:** Device & Simulator

## Documentation

- **BUILD_GUIDE.md** - Detailed build instructions
- **DEVICE_INSTALLATION.md** - Step-by-step device setup
- **iOS_COMPATIBILITY.md** - Feature compatibility matrix

## Support

For issues:
1. Check error logs in Xcode Console
2. Review BUILD_GUIDE.md
3. See DEVICE_INSTALLATION.md for device-specific issues
4. Check Apple Developer documentation: https://developer.apple.com/documentation/

## Next Steps

1. ✅ Project files created
2. ⏭️ **Open in Xcode** → `open WordClockWidgets.xcworkspace`
3. ⏭️ **Configure signing** → Select team in Xcode
4. ⏭️ **Select device** → iPhone XS or simulator
5. ⏭️ **Build** → Cmd+B
6. ⏭️ **Run** → Cmd+R
7. ⏭️ **Test widget** → Long-press home screen → Add widget

---

**Status:** ✅ Ready for compilation and installation on iOS 18.4.1

**Last Updated:** 2026-04-04

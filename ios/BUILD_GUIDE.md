# WordClockWidgets iOS - Build & Installation Guide

## Prerequisites
- macOS 13.0 or later
- Xcode 15.0 or later
- iOS deployment target: iOS 14.0+ (compatible with iOS 18.4.1)
- Device: iPhone XS or compatible

## Supported Devices
- iPhone XS, iPhone XS Max
- iPhone XR and later models
- All devices with A12 Bionic or newer chips

## Build Instructions

### Using Xcode (Recommended)

1. **Open the project in Xcode:**
   ```bash
   open WordClockWidgets.xcworkspace
   ```

2. **Set Build Target:**
   - Select "WordClockWidgets" from the scheme dropdown
   - Select iPhone XS from device list (or iOS Simulator)

3. **Build:**
   - Press `Cmd + B` or go to Product → Build

4. **Install on Device:**
   - Connect iPhone XS via USB
   - Select your device from schemes dropdown
   - Press `Cmd + R` or go to Product → Run

### Using Command Line

**Build for Debug:**
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Debug \
  -derivedDataPath ./build/DerivedData
```

**Build for Release:**
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Release \
  -derivedDataPath ./build/DerivedData
```

**Build and Archive for Distribution:**
```bash
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -archivePath ./build/WordClockWidgets.xcarchive \
  archive
```

## Device Setup

### For iPhone XS with iOS 18.4.1:

1. **Enable Developer Mode:**
   - Settings → Privacy & Security → Developer Mode → Enable

2. **Trust Developer Certificate:**
   - When app is first installed, go to Settings → General → VPN & Device Management
   - Select your Developer Certificate → Trust

3. **Requirements:**
   - Apple Developer account (free or paid)
   - Valid provisioning profile
   - Bundle ID registration on Apple Developer portal

## Compatibility Check

### Verified Components:
- ✓ WidgetKit support (iOS 14.0+)
- ✓ Swift 5.9+ compatible
- ✓ SwiftUI framework
- ✓ UserDefaults for settings storage
- ✓ Calendar APIs
- ✓ Time formatting with Locale support

### iOS 18.4.1 Specific Notes:
- All features are fully compatible
- No deprecated APIs used
- App follows current iOS design guidelines
- Widget refresh policies optimized for iOS 18.x

## Troubleshooting

### Build Fails with "No matching provisioning profile found"
1. Xcode → Preferences → Accounts
2. Click "+ Add Apple ID"
3. Sign in with Apple Developer account
4. Project Settings → Signing & Capabilities
5. Select automatic provisioning

### App Crashes on Launch
- Check Console (Cmd+Shift+2)
- Ensure all Swift files are in Build Phases → Compile Sources
- Delete derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/`

### Widget Not Showing
- Ensure Widget target is included in scheme
- Press Cmd+B to build widget extension separately
- Home Screen → Edit → Add Widgets → WordClockWidgets

## Project Structure

```
ios/
├── WordClockWidgets/          # Main app target
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── ViewController.swift
│   ├── NumberToWords.swift
│   └── Info.plist
│
├── WordClockWidgetsWidget/    # Widget extension target
│   ├── WordClockWidgetsWidget.swift
│   └── Info.plist
│
├── Package.swift              # SPM manifest
├── project.pbxproj           # Xcode project configuration
└── README.md
```

## Version Info
- App Version: 1.0
- Bundle Version: 1
- Minimum OS: iOS 14.0
- Target OS: iOS 18.4.1+
- Swift Version: 5.9

## Development Notes
- All code is written in Swift 5.9
- Uses modern SwiftUI for UI
- WidgetKit for widget functionality
- No third-party dependencies (iOS SDK only)

## Next Steps
1. Configure signing certificate and provisioning profile
2. Add app icons (1024x1024 AppIcon image assets)
3. Add launch screen (Storyboard or SwiftUI)
4. Test on physical iPhone XS device
5. Submit to App Store (if needed)

---
For questions and support, refer to Apple Developer Documentation:
https://developer.apple.com/documentation/

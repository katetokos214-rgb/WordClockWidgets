# WordClockWidgets iOS - Build & Deployment Guide

## ✅ Build Status

Latest iOS build: **SUCCESS** (GitHub Actions)
- Run ID: [23983746028](https://github.com/ideoma-last/WordClockWidgets/actions/runs/23983746028)
- Build time: ~17 seconds
- Platform: macOS 14.x (GitHub Actions runner)

## Architecture Overview

This iOS project uses **Swift Package Manager (SPM)** for dependency management and builds:

```
ios/
├── Package.swift                 # Swift Package configuration
├── WordClockWidgets/             # Main app target
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   ├── ViewController.swift       # Configuration UI with joystick controls
│   ├── NumberToWords.swift        # Russian text conversion
│   ├── WidgetPreferences.swift    # UserDefaults-based persistent settings
│   ├── CompatibilityChecker.swift # iOS 18.4.1 compatibility validation
│   └── Info.plist
└── WordClockWidgetsWidget/       # WidgetKit extension
    ├── WordClockWidgetsWidget.swift
    └── Info.plist
```

## Build System: Swift Package Manager

We use **SPM** instead of traditional Xcode projects for:
- ✅ Simpler CI/CD integration on GitHub Actions
- ✅ No pbxproj/.xcworkspace maintenance required
- ✅ Cross-platform build capability (iOS, macOS, Linux)
- ✅ Faster compilation (3 seconds for main target)
- ✅ Cleaner git history (no binary project files)

## Building Locally

### Prerequisites
- macOS 13+ with Xcode 15+
- `xcode-select --install` to ensure tools are available

### Build Commands

```bash
cd ios/

# Build main app
swift build -c release --target WordClockWidgets \
  -Xswiftc -target -Xswiftc arm64-apple-ios14.0

# Build widget extension
swift build -c release --target WordClockWidgetsWidget \
  -Xswiftc -target -Xswiftc arm64-apple-ios14.0

# Or use the shorthand for development
swift build
```

### Xcode IDE Development

To work in Xcode IDE (with UI building, debugging, simulator):

```bash
# Create temporary workspace for Xcode
cd ios/
swift package generate-xcodeproj

# Then open in Xcode
open *.xcodeproj
```

## Continuous Integration (GitHub Actions)

GitHub Actions automatically builds on every push to `ios-port` branch.

### Workflow File
- Location: `.github/workflows/build-ios.yml`
- Triggers: Push to `ios-port` or `main` branches
- Runner: `macos-latest` (macOS 14.x with Xcode 15.3+)

### Build Pipeline Steps
1. **Checkout** - Clone repository
2. **Environment** - Verify xcodebuild & swift versions
3. **Validate** - Check Package.swift syntax
4. **Build Main App** - Compile WordClockWidgets target
5. **Build Widget** - Compile WordClockWidgetsWidget target
6. **Verify** - Check .swiftmodule and build artifacts
7. **Report** - Generate build summary
8. **Upload** - Save artifacts to Azure Storage

### Download Build Artifacts

Artifacts include:
- Compiled object files (.o)
- Swift module files (.swiftmodule)
- Build logs
- Build report (BUILD_REPORT.md)

To download:
1. Go to [Actions](https://github.com/ideoma-last/WordClockWidgets/actions)
2. Click the latest "Build iOS App" run
3. Download "ios-build-artifacts" zip file

## Key Swift Source Files

### AppDelegate.swift
- Application entry point
- Initializes AppDelegate and returns true
- Runs CompatibilityChecker to verify iOS 18.4.1 support

### ViewController.swift  
- Main UI Controller with UIView
- Joystick buttons for positioning elements (up/down/left/right)
- Configure button to open settings
- SaveButton and ResetButton for layout management

### NumberToWords.swift
- Converts numbers to Russian words (for clock display)
- Numbers 0-59 for minutes and hours
- Day names in Russian (понедельник, вторник, etc.)

### WidgetPreferences.swift
- Stores user settings in UserDefaults
- Persistent across app restarts and updates
- Manages position offsets, color schemes, text size

### CompatibilityChecker.swift
- Detects device model and iOS version
- Validates WidgetKit support
- Warns users on older iOS versions

### WordClockWidgetsWidget.swift (Widget Extension)
- WidgetKit timeline provider for home screen widget
- Updates every 5 minutes or on significant time change
- Displays Russian text clock with current time

## Deployment to App Store

### Prerequisites for Production
1. Apple Developer Account ($99/year)
2. Provisioning Profiles (automatic or manual)
3. Code Signing Certificates
4. Bundle ID registration (e.g., com.yourcompany.wordclockwidgets)

### Steps
1. Update Bundle ID in Info.plist files
2. Set Team ID in Xcode project settings
3. Select code signing identity
4. Archive: `File → Product → Archive`
5. Upload to App Store Connect
6. Fill in app details, screenshots, description
7. Submit for review

### Code Signing in CI/CD

For automatic code signing in GitHub Actions:
```yaml
env:
  APPLE_ID: ${{ secrets.APPLE_ID }}
  APP_PASSWORD: ${{ secrets.APP_PASSWORD }}
```

See fastlane integration for automated deployment.

## Testing

### Unit Tests
```bash
swift test --target WordClockWidgets
```

### Manual Testing on Device
1. Connect iPhone XS via USB
2. Trust the computer on device
3. Select device in Xcode
4. Press Cmd+R to build and run

### Simulator Testing
```bash
# Run in iPhone XS simulator
swift build --target WordClockWidgets
```

## Troubleshooting

### Issue: "Cannot find framework"
```
Error: Error Domain=IDEErrorDomain Code=IDETestOperationOnlySupportsTestableHostApplication
```
**Solution**: Ensure targets are properly defined in Package.swift

### Issue: "Swift module not found"
```
error: unable to find module for target WordClockWidgets
```
**Solution**: Check naming matches between Swift files and target name in Package.swift

### Issue: "iOS deployment target too low"
```
error: The iOS deployment target 'IPHONEOS_DEPLOYMENT_TARGET' is set to 13.0
```
**Solution**: Update Platform requirement in Package.swift:
```swift
.iOS(.v14)  // Minimum iOS 14
```

## Performance Notes

- **Build Time**: ~3 seconds (local), ~17 seconds (CI)
- **App Size**: ~2MB (varies with compiler optimizations)
- **Runtime Memory**: ~50MB (varies with widgets enabled)
- **Battery Impact**: Minimal (widget updates every 5 minutes)

## File Size Breakdown

```
Swift Source Files:        ~28 KB
Build Artifacts:           ~2-5 MB
Documentation:             ~30 KB
Configuration Files:       ~10 KB
```

## Future Improvements

- [ ] Add unit tests for NumberToWords conversion
- [ ] Add UI tests for ViewController interactions
- [ ] Implement fastlane for automated App Store deployments
- [ ] Add SwiftUI migration (iOS 14+)
- [ ] Create macOS version using Swift Package Manager
- [ ] Add Linux build target (if needed)

## References

- [Swift Package Manager Documentation](https://swift.org/package-manager/)
- [Building an iOS app from the command line](https://github.com/xcptools/xcrun-docs)
- [GitHub Actions for iOS Development](https://github.com/actions/setup-xcode)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)

## Support & Contribution

For issues, feature requests, or contributions:
1. Check existing [Issues](../../issues)
2. Create a new Issue with:
   - iOS version
   - Device model (e.g., iPhone XS)
   - Xcode version
   - Clear description and steps to reproduce

## License

This project is part of WordClockWidgets. See main [README.md](../README.md) for license information.

---

**Last Updated**: April 4, 2026
**Build System**: Swift Package Manager 5.9+
**Minimum iOS**: 14.0
**Target iOS**: 18.4.1
**Primary Device**: iPhone XS (A12 Bionic)

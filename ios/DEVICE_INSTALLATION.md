# iOS Device Installation Guide

## For iPhone XS with iOS 18.4.1

### Prerequisites
- macOS 13.0 or later with Xcode 15+
- iPhone XS with iOS 18.4.1
- USB cable (Lightning, compatible with iPhone XS)
- Apple ID (for code signing)
- Optional: Developer Account (for physical device deployment)

### Step 1: Prepare iPhone XS

1. **Enable Developer Mode:**
   - Settings → Privacy & Security → Developer Mode
   - Toggle "Developer Mode" ON
   - Restart device when prompted

2. **Trust Computer:**
   - Plug in iPhone XS via USB to Mac
   - Unlock iPhone
   - Tap "Trust" on the dialog

3. **Note the Device UDID:**
   - Open Xcode → Window → Devices and Simulators
   - Select iPhone XS from the left sidebar
   - Copy the UDID (if needed for provisioning)

### Step 2: Configure Xcode Project

1. **Open Project in Xcode:**
   ```bash
   open WordClockWidgets.xcworkspace
   ```

2. **Add Apple ID to Xcode:**
   - Xcode → Preferences → Accounts
   - Click "+" to add Apple ID
   - Sign in with your Apple ID
   - Click "Done"

3. **Configure Signing:**
   - Select "WordClockWidgets" project in navigator
   - Select "WordClockWidgets" target (main app)
   - Go to "Signing & Capabilities" tab
   - Check "Automatically manage signing"
   - Select your Team from dropdown
   - Bundle ID: `com.akfsno.wordclockwidgets` (or your domain)

4. **Repeat for Widget Target:**
   - Select "WordClockWidgetsWidget" target
   - Repeat signing configuration
   - Use Bundle ID: `com.akfsno.wordclockwidgets.widget`

### Step 3: Build for Device

1. **Select Device:**
   - Top toolbar, change simulator to your connected iPhone XS
   - You should see "iPhone XS" in the device dropdown

2. **Build:**
   - Product → Build (Cmd+B)
   - Wait for build to complete (no errors should appear)

3. **Run on Device:**
   - Product → Run (Cmd+R)
   - 或 Click the ▶ (Play) button in toolbar
   - App will install and launch on iPhone XS

### Step 4: Trust App on Device

1. On iPhone XS:
   - Settings → General → Device Management (or VPN & Device Management)
   - Find your Developer profile
   - Tap "Trust [Your Apple ID]"
   - Confirm in dialog

2. Return to Home Screen
3. Find "WordClockWidgets" app and open it

### Step 5: Add Widget to Home Screen

1. Long-press empty area on home screen
2. Tap "+" button (Add)
3. Search for "WordClockWidgets"
4. Select widget size (small, medium, or large)
5. Tap "Add Widget"
6. Verify widget displays correctly

### Command Line Installation (Alternative)

```bash
# Build for device
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Release \
  -destination 'generic/platform=ios,name=iPhone XS' \
  -derivedDataPath ./build/DerivedData

# Install on device (requires device to be connected)
xcodebuild -workspace WordClockWidgets.xcworkspace \
  -scheme WordClockWidgets \
  -configuration Release \
  -destination 'id=<DEVICE_UDID>' \
  -derivedDataPath ./build/DerivedData \
  install
```

Replace `<DEVICE_UDID>` with actual device ID from Devices and Simulators window.

### Troubleshooting

#### "Unable to prepare device for development"
- Disconnect and reconnect USB cable
- Restart iPhone XS
- Restart Xcode
- Try: Devices and Simulators → Disconnect → Reconnect

#### "No matching provisioning profile"
- Go to Xcode → Preferences → Accounts
- Click on your Apple ID
- Click "Download Manual Profiles"
- Retry build

#### "Couldn't install app on device"
- Ensure app is not already installed (delete from home screen)
- Try: Product → Clean Build Folder (Cmd+Shift+K)
- Then rebuild and install

#### "Code signature invalid"
- Delete derived data: `rm -rf ~/Library/Developer/Xcode/DerivedData/`
- Delete app from device
- Rebuild and reinstall

#### "Couldn't attach to process"
- Kill Xcode: Force quit and reopen
- Restart iPhone XS
- Try again

### Testing Checklist

- [ ] App launches without crashes
- [ ] Time displays in Russian words
- [ ] Widget shows on lock screen
- [ ] Widget updates every minute
- [ ] App responds to touch input
- [ ] Configuration changes save
- [ ] Colors and positions persist after restart

### Performance Notes

For iPhone XS with iOS 18.4.1:
- App should launch in < 2 seconds
- Widget should update within 10 seconds of time change
- No memory warnings in Console
- No security warnings

### Distribution

To share app with others (TestFlight or App Store):

1. Create provisioning profiles on Apple Developer portal
2. Archive app: Product → Archive
3. Use Distribute Content for TestFlight or App Store submission
4. Or generate .ipa file for enterprise distribution

---

### Support Resources

- Apple Developer Documentation: https://developer.apple.com/documentation/
- Xcode Help: Help → Xcode Help
- Device Management: https://support.apple.com/en-us/HT204142

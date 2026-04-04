//
//  CompatibilityChecker.swift
//  WordClockWidgets
//
//  Created by GitHub Copilot on 2026-04-04.
//

import Foundation
import UIKit

class CompatibilityChecker {
    
    struct CompatibilityReport {
        let isCompatible: Bool
        let iOSVersion: String
        let deviceModel: String
        let warnings: [String]
        let errors: [String]
    }
    
    static func checkCompatibility() -> CompatibilityReport {
        var warnings: [String] = []
        var errors: [String] = []
        var isCompatible = true
        
        // Check iOS version
        let iOSVersion = UIDevice.current.systemVersion
        let iOSVersionComponents = iOSVersion.split(separator: ".").compactMap { Int($0) }
        
        // Required: iOS 14.0+
        if let major = iOSVersionComponents.first, major < 14 {
            errors.append("iOS version \(iOSVersion) is below minimum required (iOS 14.0)")
            isCompatible = false
        } else if let major = iOSVersionComponents.first, major >= 18 {
            // Verified for iOS 18.4.1
            if major == 18 {
                let minor = iOSVersionComponents.count > 1 ? iOSVersionComponents[1] : 0
                if minor >= 4 {
                    // iOS 18.4 or later - fully compatible
                    print("✓ iOS \(iOSVersion) is fully compatible (iOS 18.4+)")
                }
            }
        }
        
        // Check device model
        let deviceModel = UIDevice.current.model
        let deviceType = getDeviceType()
        
        // iPhone XS is compatible (A12 Bionic)
        let compatibleDevices = [
            "iPhone XS",
            "iPhone XS Max",
            "iPhone XR",
            "iPhone 11",
            "iPhone 11 Pro",
            "iPhone 11 Pro Max",
            "iPhone 12",
            "iPhone 12 mini",
            "iPhone 12 Pro",
            "iPhone 12 Pro Max",
            "iPhone 13",
            "iPhone 13 mini",
            "iPhone 13 Pro",
            "iPhone 13 Pro Max",
            "iPhone SE",
            "iPhone 14",
            "iPhone 14 Plus",
            "iPhone 14 Pro",
            "iPhone 14 Pro Max",
            "iPhone 15",
            "iPhone 15 Plus",
            "iPhone 15 Pro",
            "iPhone 15 Pro Max",
            "iPhone 16",
            "iPhone 16 Plus",
            "iPhone 16 Pro",
            "iPhone 16 Pro Max"
        ]
        
        if !compatibleDevices.contains(deviceType) && deviceModel.contains("iPhone") {
            warnings.append("Device '\(deviceType)' is not officially tested, but may still work")
        } else if !deviceModel.contains("iPhone") {
            warnings.append("Device type '\(deviceType)' is not an iPhone. App is optimized for iPhone.")
        }
        
        // Check WidgetKit support
        if #available(iOS 14.0, *) {
            print("✓ WidgetKit framework is available")
        } else {
            errors.append("WidgetKit framework not available on this iOS version")
            isCompatible = false
        }
        
        // Check UserDefaults access
        let testKey = "compatibility_test_\(UUID().uuidString)"
        UserDefaults.standard.set(true, forKey: testKey)
        if UserDefaults.standard.bool(forKey: testKey) {
            print("✓ UserDefaults access working")
            UserDefaults.standard.removeObject(forKey: testKey)
        } else {
            warnings.append("UserDefaults may have access restrictions")
        }
        
        // Check locale support
        let locale = Locale.current
        print("✓ Current locale: \(locale.identifier)")
        if locale.languageCode == "ru" {
            print("✓ Russian locale detected - optimal for word clock")
        }
        
        return CompatibilityReport(
            isCompatible: isCompatible,
            iOSVersion: iOSVersion,
            deviceModel: "\(deviceType) (\(deviceModel))",
            warnings: warnings,
            errors: errors
        )
    }
    
    static func getDeviceType() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        // Map identifier to device name
        let deviceMap: [String: String] = [
            "iPhone11,1": "iPhone XS",
            "iPhone11,2": "iPhone XS Max",
            "iPhone11,8": "iPhone XR",
            "iPhone12,1": "iPhone 11",
            "iPhone12,3": "iPhone 11 Pro",
            "iPhone12,5": "iPhone 11 Pro Max",
            "iPhone13,1": "iPhone 12 mini",
            "iPhone13,2": "iPhone 12",
            "iPhone13,3": "iPhone 12 Pro",
            "iPhone13,4": "iPhone 12 Pro Max",
            "iPhone14,2": "iPhone 13",
            "iPhone14,3": "iPhone 13 Pro",
            "iPhone14,4": "iPhone 13 Pro",
            "iPhone14,5": "iPhone 13 Pro Max",
            "iPhone14,6": "iPhone SE (3rd generation)",
            "iPhone14,7": "iPhone 14",
            "iPhone14,8": "iPhone 14 Plus",
            "iPhone15,1": "iPhone 15",
            "iPhone15,2": "iPhone 15 Plus",
            "iPhone15,3": "iPhone 15 Pro",
            "iPhone15,4": "iPhone 15 Pro Max",
            "iPhone16,1": "iPhone 16",
            "iPhone16,2": "iPhone 16 Plus",
            "iPhone16,3": "iPhone 16 Pro",
            "iPhone16,4": "iPhone 16 Pro Max"
        ]
        
        return deviceMap[identifier] ?? identifier
    }
    
    static func printReport(_ report: CompatibilityReport) {
        print("")
        print("╔════════════════════════════════════════════════╗")
        print("║     WordClockWidgets Compatibility Report      ║")
        print("╚════════════════════════════════════════════════╝")
        print("")
        print("Status: \(report.isCompatible ? "✓ COMPATIBLE" : "✗ INCOMPATIBLE")")
        print("iOS Version: \(report.iOSVersion)")
        print("Device: \(report.deviceModel)")
        print("")
        
        if !report.errors.isEmpty {
            print("❌ Errors:")
            for error in report.errors {
                print("  • \(error)")
            }
            print("")
        }
        
        if !report.warnings.isEmpty {
            print("⚠️ Warnings:")
            for warning in report.warnings {
                print("  • \(warning)")
            }
            print("")
        }
        
        if report.isCompatible && report.errors.isEmpty {
            print("✅ All checks passed! App should work correctly.")
        }
        print("")
    }
}
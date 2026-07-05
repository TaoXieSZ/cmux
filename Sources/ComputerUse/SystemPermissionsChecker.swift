import ApplicationServices
import CoreGraphics
import Foundation

protocol ComputerUsePermissionChecking {
    var accessibilityGranted: Bool { get }
    var screenRecordingGranted: Bool { get }

    @discardableResult
    func requestAccessibility() -> Bool

    @discardableResult
    func requestScreenRecording() -> Bool
}

struct LiveComputerUsePermissionChecker: ComputerUsePermissionChecking {
    var accessibilityGranted: Bool {
        AXIsProcessTrusted()
    }

    var screenRecordingGranted: Bool {
        CGPreflightScreenCaptureAccess()
    }

    @discardableResult
    func requestAccessibility() -> Bool {
        let options = [kAXTrustedCheckOptionPrompt as String: true] as CFDictionary
        return AXIsProcessTrustedWithOptions(options)
    }

    @discardableResult
    func requestScreenRecording() -> Bool {
        CGRequestScreenCaptureAccess()
    }
}

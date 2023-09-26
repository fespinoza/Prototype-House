// Taken from: https://gist.github.com/jaanus/7e14b31f7f445435aadac09d24397da8

#if os(iOS)

import SnapshotTesting
import SwiftUI
import XCTest

public enum TestDevice {
    case iPhone
    case iPad(orientation: ViewImageConfig.Orientation)

    var viewConfig: ViewImageConfig {
        switch self {
        case .iPhone: .iPhone15Pro
        case .iPad: .iPadPro11
        }
    }

    var name: String {
        switch self {
        case .iPhone: "iPhone"
        case let .iPad(orientation): "iPad-\(orientation.name)"
        }
    }

    var deviceTraits: UITraitCollection {
        switch self {
        case .iPhone: UITraitCollection.iPhone15Pro(.portrait)
        case .iPad: UITraitCollection.iPadPro11
        }
    }
}

extension ViewImageConfig.Orientation {
    var name: String {
        switch self {
        case .landscape: "Landscape"
        case .portrait: "Portrait"
        }
    }
}

public enum TestAppearance: String {
    case darkMode = "Dark"
    case lightMode = "Light"

    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .darkMode: .dark
        case .lightMode: .light
        }
    }
}

public extension XCTestCase {
    func assertSnapshot(
        view: some View,
        on testDevice: TestDevice,
        with appearance: TestAppearance,
        testBundleResourceURL: URL,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {
        let failureMessage = SnapshotTesting.verifySnapshot(
            of: UIHostingController(rootView: view),
            as: .image(on: testDevice.viewConfig, precision: 0.98, traits: traits(for: testDevice, with: appearance)),
            named: variantName(for: testDevice, with: appearance),
            record: isRecording,
            snapshotDirectory: checkSnapshotDirectory(
                testBundleResourceURL: testBundleResourceURL,
                file: file,
                testName: testName
            ),
            file: file,
            testName: testName,
            line: line
        )

        if let failureMessage {
            XCTFail(failureMessage, file: file, line: line)
        }
    }

    func traits(for testDevice: TestDevice, with appearance: TestAppearance) -> UITraitCollection {
        testDevice.deviceTraits.modifyingTraits { mutableTraits in
            mutableTraits.userInterfaceStyle = appearance.userInterfaceStyle
        }
    }

    func variantName(for testDevice: TestDevice, with appearance: TestAppearance) -> String {
        "\(testDevice.name)_\(appearance.rawValue)"
    }

    func checkSnapshotDirectory(testBundleResourceURL: URL, file: StaticString, testName: String) -> String? {
        let testClassFileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)
        let testClassName = testClassFileURL.deletingPathExtension().lastPathComponent
        let testBundleFolder = testBundleResourceURL.appending(path: testClassName)

        let referenceSnapshotURLInTestBundle = testBundleFolder.appending(
            path: "\(sanitizePathComponent(testName)).png"
        )

        guard 
            FileManager.default.fileExists(atPath: referenceSnapshotURLInTestBundle.path(percentEncoded: false))
        else { return nil }

        // The snapshot file is present in the test bundle, so we will instruct snapshot-testing to use the folder
        // pointing to the snapshots in the test bundle, instead of the default.
        // This is the code path that Xcode Cloud will follow, if everything is set up correctly.
        return testBundleFolder.path(percentEncoded: false)
    }

    // Copied from swift-snapshot-testing
    func sanitizePathComponent(_ string: String) -> String {
        return string
            .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
            .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
    }
}
#endif

extension ViewImageConfig {
    public static let iPhone15Pro = ViewImageConfig.iPhone15Pro(.portrait)

    /// Custom definition of the parameters of iPhone 15 Pro
    ///
    /// Values taken from: https://useyourloaf.com/blog/iphone-14-screen-sizes/
    ///
    /// - Parameter orientation: device orientation
    /// - Returns: config for snapshot test for the iPhone 15 Pro
    public static func iPhone15Pro(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize

        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 59, bottom: 21, right: 59)
            size = .init(width: 852, height: 393)
        case .portrait:
            safeArea = .init(top: 59, left: 0, bottom: 34, right: 0)
            size = .init(width: 393, height: 852)
        }

        return .init(safeArea: safeArea, size: size, traits: .iPhone15Pro(orientation))
    }
}

extension UITraitCollection {
    public static func iPhone15Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        .iPhone13(orientation)
    }
}

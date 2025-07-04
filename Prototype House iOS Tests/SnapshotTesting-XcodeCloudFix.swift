// Taken from: https://gist.github.com/jaanus/7e14b31f7f445435aadac09d24397da8

#if os(iOS)

    import SnapshotTesting
    import SwiftUI
    import XCTest

    class SampleClassInTestBundle {}

    extension Bundle {
        static var testBundleURL: URL {
            guard let url = Bundle(for: SampleClassInTestBundle.self).resourceURL else {
                fatalError("❌ we couldn't access to the test bundle URL")
            }
            return url
        }
    }

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
            of view: some View,
            on testDevice: TestDevice,
            in appearance: TestAppearance,
            file: StaticString = #file,
            testName: String = #function,
            line: UInt = #line
        ) {
            let testBundleResourceURL = Bundle.testBundleURL
            let snapshotName = variantName(for: testDevice, with: appearance)
            let testClassFileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)
            let testClassName = testClassFileURL.deletingPathExtension().lastPathComponent

            let folderCandidates = [
                // For SPM modules.
                testBundleResourceURL.appending(path: "__Snapshots__").appending(path: testClassName),
                // For top-level xcodeproj app target.
                testBundleResourceURL.appending(path: testClassName),
            ]

            // Default case: snapshots are not present in test bundle. This will fall back to standard SnapshotTesting behavior,
            // where the snapshots live in `__Snapshots__` folder that is adjacent to the test class.
            var snapshotDirectory: String?

            for folder in folderCandidates {
                let referenceSnapshotURLInTestBundle = folder
                    .appending(path: "\(sanitizePathComponent(testName)).\(snapshotName).png")
                if FileManager.default.fileExists(atPath: referenceSnapshotURLInTestBundle.path(percentEncoded: false)) {
                    // The snapshot file is present in the test bundle, so we will instruct snapshot-testing to use the folder
                    // pointing to the snapshots in the test bundle, instead of the default.
                    // This is the code path that Xcode Cloud will follow, if everything is set up correctly.
                    snapshotDirectory = folder.path(percentEncoded: false)
                }
                print("--- file \(referenceSnapshotURLInTestBundle)")
            }
            print("--- snapshot directory XXX: \(snapshotDirectory ?? "none")")
            print("--- bundle url: \(testBundleResourceURL) -- alt \(Bundle.testBundleURL)")

            let failureMessage = SnapshotTesting.verifySnapshot(
                of: UIHostingController(rootView: view),
                as: .image(on: testDevice.viewConfig, precision: 0.98, traits: traits(for: testDevice, with: appearance)),
                named: snapshotName,
                record: isRecording,
                snapshotDirectory: snapshotDirectory,
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

        func checkSnapshotDirectory(file: StaticString, testName: String) -> String? {
            let testBundleResourceURL = Bundle.testBundleURL
            let testClassFileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)
            let testClassName = testClassFileURL.deletingPathExtension().lastPathComponent

//        failed - No reference was found on disk. Automatically recorded snapshot: …
//
//        open "file:///Volumes/workspace/repository/Prototype%20House%20iOS%20Tests/NestedSnapshotTest/__Snapshots__/TvSnapshotTests/testTvContentView.iPhone_Dark.png"
//
//        Re-run "testTvContentView" to assert against the newly-recorded snapshot.
//
//        Failure message too large. View Attachment for complete message.

            let folderCandidates = [
                // For SPM modules.
                testBundleResourceURL.appending(path: "__Snapshots__").appending(path: testClassName),
                // For top-level xcodeproj app target.
                testBundleResourceURL.appending(path: testClassName),
            ]

            for folder in folderCandidates {
                let referenceSnapshotURLInTestBundle = folder.appending(path: "\(sanitizePathComponent(testName)).png")
                if FileManager.default.fileExists(atPath: referenceSnapshotURLInTestBundle.path(percentEncoded: false)) {
                    // The snapshot file is present in the test bundle, so we will instruct snapshot-testing to use the folder
                    // pointing to the snapshots in the test bundle, instead of the default.
                    // This is the code path that Xcode Cloud will follow, if everything is set up correctly.
                    return folder.path(percentEncoded: false)
                }
            }

            return nil
        }

        // Copied from swift-snapshot-testing
        func sanitizePathComponent(_ string: String) -> String {
            return string
                .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
                .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
        }
    }
#endif

public extension ViewImageConfig {
    static let iPhone15Pro = ViewImageConfig.iPhone15Pro(.portrait)

    /// Custom definition of the parameters of iPhone 15 Pro
    ///
    /// Values taken from: https://useyourloaf.com/blog/iphone-14-screen-sizes/
    ///
    /// - Parameter orientation: device orientation
    /// - Returns: config for snapshot test for the iPhone 15 Pro
    static func iPhone15Pro(_ orientation: Orientation) -> ViewImageConfig {
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

public extension UITraitCollection {
    static func iPhone15Pro(_ orientation: ViewImageConfig.Orientation) -> UITraitCollection {
        .iPhone13(orientation)
    }
}

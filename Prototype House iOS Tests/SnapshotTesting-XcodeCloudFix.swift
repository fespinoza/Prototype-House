// Taken from: https://gist.github.com/jaanus/7e14b31f7f445435aadac09d24397da8

#if os(iOS)

import SnapshotTesting
import SwiftUI
import XCTest

public extension XCTestCase {
    /// Test the layout of a full-screen SwiftUI view.
    ///
    /// Currently, this is hardcoded to logical width and height of iPhone 14 Pro screen. It assumes that tests are ran only on iPhone 14 Pro simulator,
    /// so you’ll need to change this also in the Xcode Cloud workflow. Change the device from “recommended iPhones” to “iPhone 14 Pro”.
    ///
    /// This currently tests the EN and ET languages, to visually spot any problems in language localization.
    ///
    /// - Parameters:
    ///   - view: The view to test.
    ///   - testBundleResourceURL: Resource URL that contains a folder with the reference screenshots.
    ///     For SPM module tests, the folder will be named `__Snapshots__/TestClassName`.
    ///     For top-level app target tests, the folder will be named simply `TestClassName`.
    ///   - file: The test file calling this function. No need to pass it, this is determined automatically.
    ///   - testName: Test function that is calling this function. No need to pass it, this is determined automatically.
    ///   - line: Line in the test file calling this function. No need to pass it, this is determined automatically.
    func assertSnapshot(
        view: some View,
        testBundleResourceURL: URL,
        file: StaticString = #file,
        testName: String = #function,
        line: UInt = #line
    ) {

        let locales = [Locale(identifier: "en_US")]

        let testClassFileURL = URL(fileURLWithPath: "\(file)", isDirectory: false)
        let testClassName = testClassFileURL.deletingPathExtension().lastPathComponent

        let folderCandidates = [
            // For SPM modules.
            testBundleResourceURL.appending(path: "__Snapshots__").appending(path: testClassName),
            // For top-level xcodeproj app target.
            testBundleResourceURL.appending(path: testClassName)
        ]

        for locale in locales {

            // Default case: snapshots are not present in test bundle. This will fall back to standard SnapshotTesting behavior,
            // where the snapshots live in `__Snapshots__` folder that is adjacent to the test class.
            var snapshotDirectory: String? = nil

            for folder in folderCandidates {
                let referenceSnapshotURLInTestBundle = folder.appending(path: "\(sanitizePathComponent(testName)).\(locale.identifier).png")
                if FileManager.default.fileExists(atPath: referenceSnapshotURLInTestBundle.path(percentEncoded: false)) {
                    // The snapshot file is present in the test bundle, so we will instruct snapshot-testing to use the folder
                    // pointing to the snapshots in the test bundle, instead of the default.
                    // This is the code path that Xcode Cloud will follow, if everything is set up correctly.
                    snapshotDirectory = folder.path(percentEncoded: false)
                }
            }

            let failure = SnapshotTesting.verifySnapshot(
                matching: view
                    .frame(width: 393, height: 852)
                    .environment(\.locale, locale),
                // When precision is the default 100%, some snapshot tests on Xcode Cloud fail,
                // even though there is no visible difference between reference and test result images,
                // and the difference image is completely black (does not indicate any different pixels).
                // 🤷 Just lowering the tolerance a bit seems to make it more resilient.
                as: .image(
                    precision: 0.98,
                    traits: UITraitCollection(mutations: { mutableTraits in
                        mutableTraits.userInterfaceStyle = .dark
                        mutableTraits.preferredContentSizeCategory = .medium
                    })
                ),
                named: locale.identifier,
                record: false,
                snapshotDirectory: snapshotDirectory,
                file: file,
                testName: testName,
                line: line
            )

            if let message = failure {
                XCTFail(message, file: file, line: line)
            }
        }
    }

    // Copied from swift-snapshot-testing
    func sanitizePathComponent(_ string: String) -> String {
        return string
            .replacingOccurrences(of: "\\W+", with: "-", options: .regularExpression)
            .replacingOccurrences(of: "^-|-$", with: "", options: .regularExpression)
    }
}
#endif

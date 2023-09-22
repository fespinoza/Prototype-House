// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SamplePackage",
    defaultLocalization: "en",
    platforms: [.iOS(.v15), .watchOS(.v9), .macOS(.v13)],
    products: [
        .library(
            name: "SamplePackage",
            targets: ["SamplePackage"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SamplePackage",
            dependencies: []
        ),
        .testTarget(
            name: "SamplePackageTests",
            dependencies: ["SamplePackage"]
        ),
    ]
)

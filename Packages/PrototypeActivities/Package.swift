// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "PrototypeActivities",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "PrototypeActivities",
            targets: ["PrototypeActivities"]
        ),
    ],
    targets: [
        .target(name: "PrototypeActivities"),
        .testTarget(
            name: "PrototypeActivitiesTests",
            dependencies: ["PrototypeActivities"]
        ),
    ]
)

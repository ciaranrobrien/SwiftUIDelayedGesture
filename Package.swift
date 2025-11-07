// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "SwiftUIDelayedGesture",
    platforms: [
        .iOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(name: "SwiftUIDelayedGesture", targets: ["SwiftUIDelayedGesture"])
    ],
    targets: [
        .target(name: "SwiftUIDelayedGesture", dependencies: [])
    ]
)

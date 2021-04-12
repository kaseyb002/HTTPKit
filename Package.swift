// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPKit",
    products: [
        .library(
            name: "HTTPKit",
            targets: ["HTTPKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "HTTPKit",
            dependencies: []),
        .testTarget(
            name: "HTTPKitTests",
            dependencies: ["HTTPKit"]),
    ]
)

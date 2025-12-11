// swift-tools-version:6.2

import PackageDescription
let package = Package(
    name: "HTTPKit",
    products: [
        .library(
            name: "HTTPKit",
            targets: ["HTTPKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HTTPKit",
            dependencies: []),
        .testTarget(
            name: "HTTPKitTests",
            dependencies: ["HTTPKit"]),
    ]
)

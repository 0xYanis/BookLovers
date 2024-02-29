// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AlertKit",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "AlertKit",
            targets: ["AlertKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AlertKit",
            dependencies: [])
    ]
)

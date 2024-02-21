// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Managers",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Managers",
            targets: ["Managers"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Managers",
            dependencies: []),
        .testTarget(
            name: "ManagersTests",
            dependencies: ["Managers"]),
    ]
)

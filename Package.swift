// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfomaniakCoreUI",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "InfomaniakCoreCommonUI",
            targets: ["InfomaniakCoreCommonUI"]),
        .library(
            name: "InfomaniakCoreUIKit",
            targets: ["InfomaniakCoreUIKit"]),
        .library(
            name: "InfomaniakCoreSwiftUI",
            targets: ["InfomaniakCoreSwiftUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "12.0.0")),
        .package(url: "https://github.com/Infomaniak/SnackBar.swift", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.10.0")),
        .package(url: "https://github.com/matomo-org/matomo-sdk-ios", .upToNextMajor(from: "7.5.2"))
    ],
    targets: [
        .target(
            name: "InfomaniakCoreCommonUI",
            dependencies: [
                "Kingfisher",
                .product(name: "MatomoTracker", package: "matomo-sdk-ios"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "SnackBar", package: "SnackBar.swift")
            ]),
        .target(
            name: "InfomaniakCoreUIKit",
            dependencies: [
                "InfomaniakCoreCommonUI",
            ]),
        .target(
            name: "InfomaniakCoreSwiftUI",
            dependencies: []),
        .testTarget(
            name: "InfomaniakCoreUITests",
            dependencies: ["InfomaniakCoreCommonUI", "InfomaniakCoreUIKit", "InfomaniakCoreSwiftUI"])
    ]
)

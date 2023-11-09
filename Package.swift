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
            name: "InfomaniakCoreUI",
            targets: ["InfomaniakCoreUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "4.1.11")),
        .package(url: "https://github.com/Infomaniak/LocalizeKit", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/Infomaniak/SnackBar.swift", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/matomo-org/matomo-sdk-ios", .upToNextMajor(from: "7.5.2"))
    ],
    targets: [
        .target(
            name: "InfomaniakCoreUI",
            dependencies: [
                "LocalizeKit",
                "Kingfisher",
                .product(name: "MatomoTracker", package: "matomo-sdk-ios"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "SnackBar", package: "SnackBar.swift")
            ]),
        .testTarget(
            name: "InfomaniakCoreUITests",
            dependencies: ["InfomaniakCoreUI"])
    ]
)

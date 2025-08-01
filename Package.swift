// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InfomaniakCoreUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "InfomaniakCoreCommonUI",
            targets: ["InfomaniakCoreCommonUI"]
        ),
        .library(
            name: "InfomaniakCoreUIKit",
            targets: ["InfomaniakCoreUIKit"]
        ),
        .library(
            name: "InfomaniakCoreSwiftUI",
            targets: ["InfomaniakCoreSwiftUI"]
        ),
        .library(
            name: "InfomaniakPrivacyManagement",
            targets: ["InfomaniakPrivacyManagement"]
        ),
        .library(
            name: "InfomaniakCoreUIResources",
            targets: ["InfomaniakCoreUIResources"]
        ),
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "15.2.0")),
        .package(url: "https://github.com/Infomaniak/SnackBar.swift", .upToNextMajor(from: "1.2.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.10.0")),
        .package(url: "https://github.com/matomo-org/matomo-sdk-ios", .upToNextMajor(from: "7.5.2")),
        .package(url: "https://github.com/shaps80/SwiftUIBackports", .upToNextMajor(from: "1.15.1")),
        .package(url: "https://github.com/siteline/SwiftUI-Introspect", .upToNextMajor(from: "1.4.0-beta.1"))
    ],
    targets: [
        .target(
            name: "InfomaniakCoreCommonUI",
            dependencies: [
                "Kingfisher",
                .product(name: "MatomoTracker", package: "matomo-sdk-ios"),
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "SnackBar", package: "SnackBar.swift")
            ]
        ),
        .target(
            name: "InfomaniakCoreUIKit",
            dependencies: ["InfomaniakCoreCommonUI"]
        ),
        .target(
            name: "InfomaniakCoreSwiftUI",
            dependencies: [
                "SwiftUIBackports",
                "DesignSystem",
                "InfomaniakCoreUIResources",
                "InfomaniakCoreCommonUI",
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "SwiftUIIntrospect-Static", package: "SwiftUI-Introspect")
            ]
        ),
        .target(
            name: "InfomaniakPrivacyManagement",
            dependencies: [
                "DesignSystem",
                "InfomaniakCoreSwiftUI"
            ]
        ),
        .target(
            name: "InfomaniakCoreUIResources"
        ),
        .target(
            name: "DesignSystem"
        ),
        .testTarget(
            name: "InfomaniakCoreUITests",
            dependencies: ["InfomaniakCoreCommonUI", "InfomaniakCoreUIKit", "InfomaniakCoreSwiftUI"]
        )
    ]
)

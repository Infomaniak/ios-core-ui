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
        .package(url: "https://github.com/Infomaniak/ios-core", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.0.0")),
        .package(url: "https://github.com/PhilippeWeidmann/LocalizeKit", .upToNextMajor(from: "1.0.1")),
        .package(url: "https://github.com/PhilippeWeidmann/SnackBar.swift", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "InfomaniakCoreUI",
            dependencies: [
                "LocalizeKit",
                "Kingfisher",
                .product(name: "InfomaniakCore", package: "ios-core"),
                .product(name: "SnackBar", package: "SnackBar.swift")
            ]),
        .testTarget(
            name: "InfomaniakCoreUITests",
            dependencies: ["InfomaniakCoreUI"])
    ]
)

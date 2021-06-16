// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mobile Buy SDK",
    platforms: [
        .iOS(.v12),
        .watchOS(.v2),
        .tvOS(.v12),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "Buy",
            targets: ["Buy"]
        ),
        .library(
            name: "Pay",
            targets: ["Pay"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Buy",
            dependencies: [],
            path: "Buy",
            exclude: ["Info.plist"]
        ),
        .target(
            name: "Pay",
            dependencies: [],
            path: "Pay",
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "BuyTests",
            dependencies: ["Buy"],
            path: "BuyTests",
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "PayTests",
            dependencies: ["Pay"],
            path: "PayTests",
            exclude: ["Info.plist"]
        ),
    ]
)

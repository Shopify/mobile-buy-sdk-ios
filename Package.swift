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
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Buy",
            dependencies: [],
            path: "Buy",
            exclude: ["Info.plist"]
        ),
        .testTarget(
            name: "BuyTests",
            dependencies: ["Buy"],
            path: "BuyTests",
            exclude: ["Info.plist"]
        ),
    ]
)

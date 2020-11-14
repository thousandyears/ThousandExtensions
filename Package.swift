// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ThousandExtensions",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        .library(name: "ThousandExtensions", targets: ["ThousandExtensions"]),
        .library(name: "SKExtensions", targets: ["SKExtensions"]),
        .library(name: "CombineExtensions", targets: ["CombineExtensions"]),
        .library(name: "FoundationExtensions", targets: ["FoundationExtensions"]),
        .library(name: "Drawing", targets: ["Drawing"]),
        .library(name: "Space", targets: ["Space"]),
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Peek.git", .branch("trunk")),
        .package(url: "https://github.com/screensailor/Hope.git", .branch("trunk")),
        .package(url: "https://github.com/apple/swift-numerics.git", .upToNextMajor(from: "0.0.6")),
        .package(url: "https://github.com/screensailor/Lark.git", .branch("trunk")),
        .package(url: "https://github.com/screensailor/Hope.git", .branch("trunk")),
        .package(url: "https://github.com/screensailor/Peek.git", .branch("trunk")),
    ],
    targets: [
        // libraries:
        .target(name: "ThousandExtensions", dependencies: ["SKExtensions"]),
        .target(name: "SKExtensions", dependencies: ["FoundationExtensions", "CombineExtensions"]),
        .target(name: "CombineExtensions", dependencies: ["FoundationExtensions"]),
        .target(name: "FoundationExtensions", dependencies: ["SwiftExtensions", "Drawing"]),
        .target(name: "Drawing", dependencies: ["Space"]),
        .target(name: "Space", dependencies: ["SwiftExtensions"]),
        .target(name: "SwiftExtensions", dependencies: [
            .byName(name: "Peek"),
            .product(name: "Numerics", package: "swift-numerics"),
        ]),
        // tests:
        .testTarget(name: "DrawingTests", dependencies: ["Drawing", "Hope"]),
    ]
)

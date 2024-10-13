// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "ThousandExtensions",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
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
        .package(url: "https://github.com/thousandyears/Peek.git", .branch("trunk")),
        .package(url: "https://github.com/thousandyears/Hope.git", .branch("trunk")),
        .package(url: "https://github.com/apple/swift-numerics.git", .upToNextMajor(from: "0.0.6")),
    ],
    targets: [
        // libraries:
        .target(name: "ThousandExtensions", dependencies: ["SKExtensions"]),
        .target(name: "SKExtensions", dependencies: ["FoundationExtensions", "CombineExtensions"]),
        .target(name: "CombineExtensions", dependencies: ["FoundationExtensions", "SwiftExtensions"]),
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

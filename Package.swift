// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ThousandExtensions",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "ThousandExtensions", targets: ["ThousandExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-numerics.git", .upToNextMajor(from: "0.0.6")),
    ],
    targets: [
        // libraries:
        .target(name: "ThousandExtensions", dependencies: ["SKExtensions"]),
        .target(name: "SKExtensions", dependencies: ["FoundationExtensions", "CombineExtensions"]),
        .target(name: "CombineExtensions"),
        .target(name: "FoundationExtensions", dependencies: ["SwiftExtensions", "Drawing"]),
        .target(name: "Drawing", dependencies: ["Space"]),
        .target(name: "Space", dependencies: ["SwiftExtensions"]),
        .target(name: "SwiftExtensions", dependencies: [
            .byName(name: "Peek"),
            .product(name: "Numerics", package: "swift-numerics"),
        ]),
        .target(name: "Peek"),
        .target(name: "Hope"),

        // tests:
        .testTarget(name: "DrawingTests", dependencies: ["Drawing", "Hope"]),
        .testTarget(name: "PeekTests", dependencies: ["Peek", "Hope"]),
    ]
)

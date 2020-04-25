// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ThousandExtensions",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "ThousandExtensions", targets: ["ThousandExtensions"]),
        .library(name: "CGExtensions", targets: ["CGExtensions"]),
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"]),
        .library(name: "XCTExtensions", targets: ["XCTExtensions"]),
        .library(name: "DebugExtensions", targets: ["DebugExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Space.git", .branch("master")),
        .package(url: "https://github.com/screensailor/KeyPathArithmetic.git", .branch("master")),
        .package(url: "https://github.com/screensailor/DictionaryArithmetic.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Hope.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Peek.git", .branch("master")),
    ],
    targets: [
        .target(name: "ThousandExtensions", dependencies: ["SwiftExtensions", "CGExtensions"]),
        .target(name: "CGExtensions", dependencies: ["SwiftExtensions"]),
        .target(name: "SwiftExtensions", dependencies: ["DebugExtensions", "DictionaryArithmetic", "KeyPathArithmetic", "Space"]),
        .target(name: "XCTExtensions", dependencies: ["DebugExtensions", "Hope"]),
        .target(name: "DebugExtensions", dependencies: ["Peek"]),
    ]
)

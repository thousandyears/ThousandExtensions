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
        .library(name: "SKExtensions", targets: ["SKExtensions"]),
        .library(name: "FoundationExtensions", targets: ["FoundationExtensions"]),
        .library(name: "CGExtensions", targets: ["CGExtensions"]),
        .library(name: "SwiftExtensions", targets: ["SwiftExtensions"]),
        .library(name: "XCTExtensions", targets: ["XCTExtensions"]),
        .library(name: "DebugExtensions", targets: ["DebugExtensions"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Periscope.git", .branch("master")),
        .package(url: "https://github.com/ollieatkinson/NamedPoint.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Drawing.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Space.git", .branch("master")),
        .package(url: "https://github.com/screensailor/KeyPathArithmetic.git", .branch("master")),
        .package(url: "https://github.com/screensailor/DictionaryArithmetic.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Hope.git", .branch("master")),
        .package(url: "https://github.com/screensailor/TrySwitch.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Peek.git", .branch("master")),
    ],
    targets: [
        .target(name: "ThousandExtensions", dependencies: ["FoundationExtensions", "SKExtensions", "Periscope"]),
        .target(name: "SKExtensions", dependencies: ["FoundationExtensions"]),
        .target(name: "FoundationExtensions", dependencies: ["CGExtensions"]),
        .target(name: "CGExtensions", dependencies: ["SwiftExtensions", "NamedPoint", "Space", "Drawing"]),
        .target(name: "SwiftExtensions", dependencies: ["DebugExtensions", "TrySwitch", "DictionaryArithmetic", "KeyPathArithmetic"]),
        .target(name: "XCTExtensions", dependencies: ["DebugExtensions", "Hope", "TrySwitch"]),
        .target(name: "DebugExtensions", dependencies: ["Peek"]),
    ]
)

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
        .library(name: "STD", targets: ["STD"]),
        .library(name: "Bug", targets: ["Bug"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Space.git", .branch("master")),
        .package(url: "https://github.com/screensailor/DictionaryArithmetic.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Peek.git", .branch("master")),
    ],
    targets: [
        .target(name: "ThousandExtensions", dependencies: ["Bug", "STD"]),
        .target(name: "STD", dependencies: ["Peek", "DictionaryArithmetic", "Space"]),
        .target(name: "Bug", dependencies: ["Peek"]),
    ]
)

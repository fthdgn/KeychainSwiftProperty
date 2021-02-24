// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "KeychainSwiftProperty",
    products: [
        .library(
            name: "KeychainSwiftProperty",
            targets: ["KeychainSwiftProperty"]),
    ],
    dependencies: [
        .package(name: "KeychainSwift", url: "https://github.com/evgenyneu/keychain-swift.git", from:"19.0.0"),
    ],
    targets: [
        .target(
            name: "KeychainSwiftProperty",
            dependencies: [
                .product(name: "KeychainSwift", package: "KeychainSwift"),
            ]),
        .testTarget(
            name: "KeychainSwiftPropertyTests",
            dependencies: ["KeychainSwiftProperty"]),
    ]
)

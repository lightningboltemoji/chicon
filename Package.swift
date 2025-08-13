// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "chicon",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v15)
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1")
    ],
    targets: [
        .executableTarget(
            name: "chicon",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        )
    ]
)

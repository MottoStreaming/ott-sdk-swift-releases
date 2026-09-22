// swift-tools-version: 6.0
//
// The Motto OTT SDK for Apple platforms, 1.0.1: a compiled Swift package.
//
// Every module an import needs is a binary target — the SDK's own, the
// generated CDA schema modules, and the SwiftProtobuf build they were compiled
// against (the Connect transport is linked inside OttCore) — so an application
// adds nothing else to its manifest. The package manager downloads each
// XCFramework from the URL below and checks it against its checksum.
import PackageDescription

let package = Package(
    name: "OttSDK",
    platforms: [.iOS(.v18), .tvOS(.v18)],
    products: [
        .library(name: "OttCore", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf"]),
        .library(name: "OttPlayer", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf", "OttPlayerDependencies"]),
        .library(name: "OttPageComponents", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf", "OttPlayerDependencies"]),
        .library(name: "OttNavigation", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf", "OttPlayerDependencies"]),
        .library(name: "OttAuth", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf", "OttPlayerDependencies"]),
        .library(name: "OttCheckout", targets: ["OttCore", "OttPlayer", "OttPageComponents", "OttNavigation", "OttAuth", "OttCheckout", "MottoCDA", "SwiftProtobuf", "OttPlayerDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-ios.git", from: "3.33.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-tvos.git", from: "4.17.0"),
    ],
    targets: [
        // Google IMA, which OttPlayer's binary was compiled against: a binary
        // target cannot declare dependencies, so this target carries them.
        .target(
            name: "OttPlayerDependencies",
            dependencies: [
                .product(name: "GoogleInteractiveMediaAds", package: "swift-package-manager-google-interactive-media-ads-ios", condition: .when(platforms: [.iOS])),
                .product(name: "GoogleInteractiveMediaAdsTvOS", package: "swift-package-manager-google-interactive-media-ads-tvos", condition: .when(platforms: [.tvOS])),
            ]
        ),
        .binaryTarget(
            name: "OttCore",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttCore.xcframework.zip",
            checksum: "2baa9a5a80025839ba46a92a09744ea553c43d02bb66a688ec72d59385cb37ef"
        ),
        .binaryTarget(
            name: "OttPlayer",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttPlayer.xcframework.zip",
            checksum: "841ed39bedd9849b74344691d5ddc32943222afea09a22d59d5ac1e6eb0b62d2"
        ),
        .binaryTarget(
            name: "OttPageComponents",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttPageComponents.xcframework.zip",
            checksum: "b926c9d2938189b1c9e7fb087820724ab3e463d5df51560e3ef0a697b527bd23"
        ),
        .binaryTarget(
            name: "OttNavigation",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttNavigation.xcframework.zip",
            checksum: "9ca7ae0e7f879af0b8bd854a6248b8dbb77a99184e63b8267b6bff2f24677412"
        ),
        .binaryTarget(
            name: "OttAuth",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttAuth.xcframework.zip",
            checksum: "53dc596dbc5577a1e55f13f13b30ab3394bcf5db3c25d82999a711060f72e577"
        ),
        .binaryTarget(
            name: "OttCheckout",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/OttCheckout.xcframework.zip",
            checksum: "c3b06ac57e1ee42e46a22cabb10486dc174653b56e013ffa8b7cfe9c32dfdd0b"
        ),
        .binaryTarget(
            name: "MottoCDA",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/MottoCDA.xcframework.zip",
            checksum: "fcffdc3fc9b59b604cd885ebbea863428ff7b73413032aabcbf06ded2aaaf709"
        ),
        .binaryTarget(
            name: "SwiftProtobuf",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.1/SwiftProtobuf.xcframework.zip",
            checksum: "e67685f97236612dcc9d6b7d62f4d290c0b6e8476cc84dd6f0572fad7e786f0f"
        ),
    ]
)

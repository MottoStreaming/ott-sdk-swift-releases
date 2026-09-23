// swift-tools-version: 6.0
//
// The Motto OTT SDK for Apple platforms, 1.1.0: a compiled Swift package.
//
// Every module an import needs is a binary target — the SDK's own, the
// generated CDA schema modules, and the SwiftProtobuf build they were compiled
// against (the Connect transport is linked inside MottoOTTCore) — so an application
// adds nothing else to its manifest. The package manager downloads each
// XCFramework from the URL below and checks it against its checksum.
import PackageDescription

let package = Package(
    name: "MottoOTTSDK",
    platforms: [.iOS(.v18), .tvOS(.v18)],
    products: [
        .library(name: "MottoOTTCore", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf"]),
        .library(name: "MottoOTTPlayer", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf", "MottoOTTPlayerDependencies"]),
        .library(name: "MottoOTTPageComponents", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf", "MottoOTTPlayerDependencies"]),
        .library(name: "MottoOTTNavigation", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf", "MottoOTTPlayerDependencies"]),
        .library(name: "MottoOTTAuth", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf", "MottoOTTPlayerDependencies"]),
        .library(name: "MottoOTTCheckout", targets: ["MottoOTTCore", "MottoOTTPlayer", "MottoOTTPageComponents", "MottoOTTNavigation", "MottoOTTAuth", "MottoOTTCheckout", "MottoCDA", "SwiftProtobuf", "MottoOTTPlayerDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-ios.git", from: "3.33.0"),
        .package(url: "https://github.com/googleads/swift-package-manager-google-interactive-media-ads-tvos.git", from: "4.17.0"),
        .package(url: "https://github.com/muxinc/mux-stats-sdk-avplayer.git", from: "4.17.0"),
        .package(url: "https://github.com/muxinc/stats-sdk-objc.git", from: "5.14.0"),
    ],
    targets: [
        // Google IMA and Mux Data, which MottoOTTPlayer's binary was compiled against:
        // a binary target cannot declare dependencies, so this target carries them.
        .target(
            name: "MottoOTTPlayerDependencies",
            dependencies: [
                .product(name: "GoogleInteractiveMediaAds", package: "swift-package-manager-google-interactive-media-ads-ios", condition: .when(platforms: [.iOS])),
                .product(name: "GoogleInteractiveMediaAdsTvOS", package: "swift-package-manager-google-interactive-media-ads-tvos", condition: .when(platforms: [.tvOS])),
                .product(name: "MUXSDKStats", package: "mux-stats-sdk-avplayer"),
                .product(name: "MuxCore", package: "stats-sdk-objc"),
            ]
        ),
        .binaryTarget(
            name: "MottoOTTCore",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTCore.xcframework.zip",
            checksum: "00b5e3198b16f4d17784736d10d29b95f3d35285791e2e83b8d665546d879a6c"
        ),
        .binaryTarget(
            name: "MottoOTTPlayer",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTPlayer.xcframework.zip",
            checksum: "81d8fae57203b970a10af90ae9f05c52d0bad4cca8535d455a18f2d16bc0c2b0"
        ),
        .binaryTarget(
            name: "MottoOTTPageComponents",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTPageComponents.xcframework.zip",
            checksum: "b9c481acc4b46c79f57dc33c5a52ac012e16d2bf844126cf4b31942d2fec4bb8"
        ),
        .binaryTarget(
            name: "MottoOTTNavigation",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTNavigation.xcframework.zip",
            checksum: "91c2d98617bc57958e020c0db2e740436bd3dd4f3fdd7e99be3f1932b08c329c"
        ),
        .binaryTarget(
            name: "MottoOTTAuth",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTAuth.xcframework.zip",
            checksum: "acf786da641737f5874474bb0fc7a18da7ff2be8847f3cdbcce1bbf8e34d2923"
        ),
        .binaryTarget(
            name: "MottoOTTCheckout",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoOTTCheckout.xcframework.zip",
            checksum: "b609d49b20d2ac4b2ceee14a8f55e7f4f27a44791aed34ea12a7e35eb68e216b"
        ),
        .binaryTarget(
            name: "MottoCDA",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/MottoCDA.xcframework.zip",
            checksum: "81ad4a52fe257f2eee74b178cac2ecccced7eeb213dc45404fb0b68bbca5d8df"
        ),
        .binaryTarget(
            name: "SwiftProtobuf",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.1.0/SwiftProtobuf.xcframework.zip",
            checksum: "b208033574b698bfb28a0ad13ca4ccbe71def95f924f01e759b67a7f8b27dc0a"
        ),
    ]
)

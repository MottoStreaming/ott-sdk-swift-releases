// swift-tools-version: 6.0
//
// The Motto OTT SDK for Apple platforms, 1.0.2: a compiled Swift package.
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
    ],
    targets: [
        // Google IMA, which MottoOTTPlayer's binary was compiled against: a binary
        // target cannot declare dependencies, so this target carries them.
        .target(
            name: "MottoOTTPlayerDependencies",
            dependencies: [
                .product(name: "GoogleInteractiveMediaAds", package: "swift-package-manager-google-interactive-media-ads-ios", condition: .when(platforms: [.iOS])),
                .product(name: "GoogleInteractiveMediaAdsTvOS", package: "swift-package-manager-google-interactive-media-ads-tvos", condition: .when(platforms: [.tvOS])),
            ]
        ),
        .binaryTarget(
            name: "MottoOTTCore",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTCore.xcframework.zip",
            checksum: "d23d11446edf503ffabed439e9742054b6ba0d661ba56813cc6c802ad18e6402"
        ),
        .binaryTarget(
            name: "MottoOTTPlayer",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTPlayer.xcframework.zip",
            checksum: "b8412543d4c92d928fef20c9f6db9074c3bf6ae3ec82a58247aec00c273cbcbd"
        ),
        .binaryTarget(
            name: "MottoOTTPageComponents",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTPageComponents.xcframework.zip",
            checksum: "133406fde07d0619de7fa13ac67e1515576f99b324b0f685179a0e60181ccb46"
        ),
        .binaryTarget(
            name: "MottoOTTNavigation",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTNavigation.xcframework.zip",
            checksum: "35680994f3ba1b5a27d92e28072c846b34274620a3cbd26ea41987284f8a9f10"
        ),
        .binaryTarget(
            name: "MottoOTTAuth",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTAuth.xcframework.zip",
            checksum: "eded55cf4868c638c5e9013560f6003e98727c61e01423c598f3431fba519bcd"
        ),
        .binaryTarget(
            name: "MottoOTTCheckout",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoOTTCheckout.xcframework.zip",
            checksum: "92f2eb3575504a6a6f1ee24f9373095032dc3158ea2007d03e754bad451e1bfa"
        ),
        .binaryTarget(
            name: "MottoCDA",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/MottoCDA.xcframework.zip",
            checksum: "923210b1bad8a9dc21581929a8c0d28643ca7d2ece9b2290162ddd9b9c7f537b"
        ),
        .binaryTarget(
            name: "SwiftProtobuf",
            url: "https://storage.googleapis.com/motto-ott-sdk-releases/apple/1.0.2/SwiftProtobuf.xcframework.zip",
            checksum: "b719f3272a091cf937032cfca05cb81bf71c701eae375e91707acd0fd6fcfb11"
        ),
    ]
)

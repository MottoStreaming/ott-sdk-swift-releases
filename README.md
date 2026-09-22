# Motto OTT SDK for Apple platforms

The Swift SDK for building OTT applications on the Motto Content Delivery API: iOS 18+
and tvOS 18+, Swift Package Manager, compiled. The engine (`MottoOTTCore`) is `@Observable`
and `async`/`await`; SwiftUI reads it directly. This repository is its Swift package:
each tag is a release, whose manifest names that release's XCFrameworks by their
download URLs and checksums, and `SURFACE.md` is the public API map.

| Product | Purpose |
|---|---|
| `MottoOTTCore` | The engine: platform bootstrap, page sessions, the filter model, source controllers with their refresh policies, auth and the token lifecycle, playback resolution, concurrency, monetization reads, annotations, analytics, one resolver per page component. |
| `MottoOTTPlayer` | AVPlayer, FairPlay, the normalized refusal taxonomy, the headless `PlayerSession`, `PlayerView`, Google IMA ads, the Cast slot. |
| `MottoOTTPageComponents` | The page arrangement, `PageComponentStack` (the tvOS focus rules), the per-component interfaces, and the two player page components. |
| `MottoOTTNavigation` | Navigation: `TabNavigator` for an application that owns its tabs, `StackNavigator` for a section inside a host's own shell, one `open` for every target, the tvOS Menu and tab-bar semantics. |
| `MottoOTTAuth` | SwiftUI auth forms and copy, Sign in with Apple, OIDC on iOS, TV pairing. |
| `MottoOTTCheckout` | Provider-pluggable checkout: the registry, the paywall and offer surfaces, the platform's hosted checkout first. |

## Installation

In Xcode, File → Add Package Dependencies…, enter
`https://github.com/MottoStreaming/ott-sdk-swift-releases`, choose "Up to Next Major
Version" from the version you want, and add the products your targets use. In a
`Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MottoStreaming/ott-sdk-swift-releases", from: "1.0.0"),
],
targets: [
    .target(name: "App", dependencies: [
        .product(name: "MottoOTTCore", package: "ott-sdk-swift-releases"),
    ]),
]
```

The package manager downloads the XCFrameworks and checks each against the checksum in
the manifest. Then:

```swift
import MottoOTTCore

let client = MottoOTTClient(config: MottoOTTClientConfig(publicKey: "<your public key>", baseUrl: "https://your-app.example", client: "ios"))
let platform = try await client.bootstrap()
let page = try await client.pages.open("/")
```

The generated Content Delivery API types (`MottoCDA`) are re-exported by `MottoOTTCore`; nothing
else needs adding to your manifest. The SwiftProtobuf build the SDK was compiled with ships
in the package, and its Connect transport is linked inside `MottoOTTCore`, so an application must
not add its own source dependency on `swift-protobuf` or `connect-swift` alongside this
package. Every product but `MottoOTTCore` links Google IMA, which the manifest fetches from
Google's Swift packages; `MottoOTTCore` alone links nothing else.

## Versions

Each release is a tag, `<major>.<minor>.<patch>`, and the version rules are semantic: a
minor release adds, a major one may break. The reference documentation is the doc
comments on the module interfaces, which Xcode shows inline, and `SURFACE.md` is the map
of the public API.

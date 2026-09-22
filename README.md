# Motto OTT SDK for Apple platforms

The Swift SDK for building OTT applications on the Motto Content Delivery API: iOS 18+
and tvOS 18+, Swift Package Manager, compiled. The engine (`OttCore`) is `@Observable`
and `async`/`await`; SwiftUI reads it directly. This repository is its Swift package:
each tag is a release, whose manifest names that release's XCFrameworks by their
download URLs and checksums, and `SURFACE.md` is the public API map.

| Product | Purpose |
|---|---|
| `OttCore` | The engine: platform bootstrap, page sessions, the filter model, source controllers with their refresh policies, auth and the token lifecycle, playback resolution, concurrency, monetization reads, annotations, analytics, one resolver per page component. |
| `OttPlayer` | AVPlayer, FairPlay, the normalized refusal taxonomy, the headless `PlayerSession`, `PlayerView`, Google IMA ads, the Cast slot. |
| `OttPageComponents` | The page arrangement, `PageComponentStack` (the tvOS focus rules), the per-component interfaces, and the two player page components. |
| `OttNavigation` | Navigation: `TabNavigator` for an application that owns its tabs, `StackNavigator` for a section inside a host's own shell, one `open` for every target, the tvOS Menu and tab-bar semantics. |
| `OttAuth` | SwiftUI auth forms and copy, Sign in with Apple, OIDC on iOS, TV pairing. |
| `OttCheckout` | Provider-pluggable checkout: the registry, the paywall and offer surfaces, the platform's hosted checkout first. |

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
        .product(name: "OttCore", package: "ott-sdk-swift-releases"),
    ]),
]
```

The package manager downloads the XCFrameworks and checks each against the checksum in
the manifest. Then:

```swift
import OttCore

let client = OttClient(config: OttClientConfig(publicKey: "<your public key>", baseUrl: "https://your-app.example", client: "ios"))
let platform = try await client.bootstrap()
let page = try await client.pages.open("/")
```

The generated Content Delivery API types (`MottoCDA`) are re-exported by `OttCore`; nothing
else needs adding to your manifest. The SwiftProtobuf build the SDK was compiled with ships
in the package, and its Connect transport is linked inside `OttCore`, so an application must
not add its own source dependency on `swift-protobuf` or `connect-swift` alongside this
package. Every product but `OttCore` links Google IMA, which the manifest fetches from
Google's Swift packages; `OttCore` alone links nothing else.

## Embedding in an application you already have

An application with a shell of its own — its tabs, its navigation, possibly its own
sign-in — adds one section powered by the platform, a "TV" tab, and the SDK moves nothing
it does not own:

- `StackNavigator` (in `OttNavigation`) holds the one stack behind the section's root
  and applies the same routing rules as the tab shell, less the tabs. Bind its
  `pathBinding` to the section's `NavigationStack`, hand every target to `open(_:)`, and
  on tvOS put `navigationCommands(_:)` on the section's root view. Targets the host
  answers itself — its account screen, its own URL scheme — are claimed through
  `NavigationOptions.claims` and never reach the stack.
- `SectionVisibility` (in `OttCore`) tells the client when the section is on screen:
  set `isShown` from your own tab selection, and the pages beneath pause while another
  of your tabs is up.
- Identity is your choice. If your application signs viewers in itself, implement
  `HostIdentity` and set it on `OttClientConfig.hostIdentity`: your backend mints the
  Motto end-user token for your viewer, the SDK asks for it on restore and whenever it
  stops serving, persists nothing of its own, and your section never shows a sign-in of
  its own; `client.auth.setToken(_:)` pushes a change in between. If it does not, leave
  it unset and run the SDK's forms inside the section, where the way back is a pop.
- Incoming URLs stay yours to forward: a page deep link to `open(_:)`, a hosted-checkout
  landing to `Checkout`.

## Versions

Each release is a tag, `<major>.<minor>.<patch>`, and the version rules are semantic: a
minor release adds, a major one may break. The reference documentation is the doc
comments on the module interfaces, which Xcode shows inline, and `SURFACE.md` is the map
of the public API.

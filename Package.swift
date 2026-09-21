// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "IdentityVerification",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "IdentityVerification",
            targets: ["IdentityVerificationiOSSDK"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "IdentityVerificationiOSSDK",
            path: "IdentityVerificationiOSSDK.xcframework"
        )
    ]
)
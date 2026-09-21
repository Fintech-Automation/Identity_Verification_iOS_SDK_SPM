// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "IdentityVerification",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "IdentityVerification",
            targets: ["IdentityVerification"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "IdentityVerificationiOSSDK",
            path: "IdentityVerificationiOSSDK.xcframework"
        )
    ]
)
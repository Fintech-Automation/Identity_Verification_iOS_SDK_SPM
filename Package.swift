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
            path: "./IdentityVerificationiOSSDK.xcframework"
        )
    ]
)
// xcodebuild archive \
// -project _Pods.xcodeproj \
// -scheme IdentityVerificationiOSSDK \
// -destination "generic/platform=iOS" \
// -archivePath "build/IdentityVerificationiOSSDK-iOS.xcarchive" \
// SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES


// xcodebuild archive \
// -project _Pods.xcodeproj \
// -scheme IdentityVerificationiOSSDK \
// -destination "generic/platform=iOS Simulator" \
// -archivePath "build/IdentityVerificationiOSSDK-iOS-Simulator.xcarchive" \
// SKIP_INSTALL=NO BUILD_LIBRARY_FOR_DISTRIBUTION=YES

// xcodebuild -create-xcframework \
// -framework build/IdentityVerificationiOSSDK-iOS.xcarchive/Products/Library/Frameworks/IdentityVerificationiOSSDK.framework \
// -framework build/IdentityVerificationiOSSDK-iOS-Simulator.xcarchive/Products/Library/Frameworks/IdentityVerificationiOSSDK.framework \
// -output build/IdentityVerificationiOSSDK.xcframework

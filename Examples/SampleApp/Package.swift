// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SampleApp",
    platforms: [.iOS(.v14), .macOS(.v11)],
    dependencies: [
        .package(path: "../../") // InternalFirebase
    ],
    targets: [
        .executableTarget(
            name: "SampleApp",
            dependencies: [
                .product(name: "FirebaseAnalytics", package: "InternalFriebaseRepo"),
                .product(name: "FirebaseCrashlytics", package: "InternalFriebaseRepo")
            ],
            path: "Sources/SampleApp"
        )
    ]
)

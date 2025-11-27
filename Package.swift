// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "InternalFirebase",
    platforms: [.iOS(.v13)],
    products: [
        // Modüler kullanmak isteyenler için:
        .library(name: "FirebaseAnalytics", targets: ["FirebaseAnalyticsWrapper"]),
        .library(name: "FirebaseCrashlytics", targets: ["FirebaseCrashlyticsWrapper"]),
        .library(name: "FirebaseRemoteConfig", targets: ["FirebaseRemoteConfigWrapper"]),
        .library(name: "FirebaseMessaging", targets: ["FirebaseMessagingWrapper"]),
        .library(name: "FirebaseStorage", targets: ["FirebaseStorageWrapper"]),
        .library(name: "FirebaseSessions", targets: ["FirebaseSessionsWrapper"]),
        .library(name: "FirebaseCore", targets: ["FirebaseCoreWrapper"]),
        
        // Tek satırda "import Firebase" yapmak isteyenler için:
        // DÜZELTME: targets dizisine "FirebaseAllInOne" değil, aşağıda tanımladığımız "Firebase" ismini yazıyoruz.
        .library(name: "Firebase", targets: ["Firebase"]),
    ],
    targets: [
        // =======================================================
        // 1. WRAPPER TARGETS
        // =======================================================
        
        // ANALYTICS WRAPPER
        .target(
            name: "FirebaseAnalyticsWrapper",
            dependencies: [
                "FirebaseAnalyticsBinary", "FirebaseCoreBinary", "FirebaseCoreInternalBinary",
                "FirebaseInstallationsBinary", "GoogleAppMeasurementBinary",
                "GoogleAppMeasurementIdentitySupportBinary", "GoogleUtilitiesBinary",
                "nanopbBinary", "FBLPromisesBinary"
            ],
            path: "Sources/FirebaseAnalyticsWrapper",
            linkerSettings: [
                .linkedLibrary("sqlite3"),
                .linkedLibrary("z"),
                .linkedLibrary("c++"),
                .linkedFramework("StoreKit"),
                .unsafeFlags(["-ObjC"]) // Kritik
            ]
        ),
        
        // CRASHLYTICS WRAPPER
        .target(
            name: "FirebaseCrashlyticsWrapper",
            dependencies: [
                "FirebaseCrashlyticsBinary", "FirebaseCoreBinary", "FirebaseInstallationsBinary",
                "GoogleDataTransportBinary", "FirebaseSessionsBinary", "FirebaseCoreExtensionBinary",
                "FirebaseRemoteConfigInteropBinary", "PromisesBinary", "nanopbBinary", "GoogleUtilitiesBinary"
            ],
            path: "Sources/FirebaseCrashlyticsWrapper",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .unsafeFlags(["-ObjC"]) // Kritik
            ]
        ),
        
        // REMOTE CONFIG WRAPPER
        .target(
            name: "FirebaseRemoteConfigWrapper",
            dependencies: [
                "FirebaseRemoteConfigBinary", "FirebaseCoreBinary", "FirebaseInstallationsBinary",
                "FirebaseABTestingBinary", "FirebaseSharedSwiftBinary", "FirebaseRemoteConfigInteropBinary",
                "GoogleUtilitiesBinary"
            ],
            path: "Sources/FirebaseRemoteConfigWrapper",
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        
        // MESSAGING WRAPPER
        .target(
            name: "FirebaseMessagingWrapper",
            dependencies: [
                "FirebaseMessagingBinary", "FirebaseCoreBinary", "FirebaseInstallationsBinary",
                "GoogleDataTransportBinary", "GoogleUtilitiesBinary", "nanopbBinary",
                "FirebaseMessagingInteropBinary"
            ],
            path: "Sources/FirebaseMessagingWrapper",
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        
        // STORAGE WRAPPER
        .target(
            name: "FirebaseStorageWrapper",
            dependencies: [
                "FirebaseStorageBinary", "FirebaseCoreBinary", "FirebaseInstallationsBinary",
                "GTMSessionFetcherBinary", "FirebaseAppCheckInteropBinary", "FirebaseAuthInteropBinary",
                "GoogleUtilitiesBinary"
            ],
            path: "Sources/FirebaseStorageWrapper",
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),
        
        // SESSIONS WRAPPER
        .target(
            name: "FirebaseSessionsWrapper",
            dependencies: [
                "FirebaseSessionsBinary", "FirebaseCoreBinary", "FirebaseInstallationsBinary",
                "GoogleDataTransportBinary", "PromisesBinary", "GoogleUtilitiesBinary"
            ],
            path: "Sources/FirebaseSessionsWrapper",
            linkerSettings: [
                .unsafeFlags(["-ObjC"])
            ]
        ),

        // CORE WRAPPER
        .target(
            name: "FirebaseCoreWrapper",
            dependencies: [
                "FirebaseCoreBinary", 
                "FirebaseCoreInternalBinary", 
                "GoogleUtilitiesBinary"
            ],
            path: "Sources/FirebaseCoreWrapper",
            linkerSettings: [.unsafeFlags(["-ObjC"])]
        ),

        // UMBRELLA TARGET (HER ŞEY DAHİL)
        // Target ismi "Firebase" olduğu için kodda "import Firebase" çalışır.
        .target(
            name: "Firebase",
            dependencies: [
                "FirebaseAnalyticsWrapper",
                "FirebaseCrashlyticsWrapper",
                "FirebaseRemoteConfigWrapper",
                "FirebaseMessagingWrapper",
                "FirebaseSessionsWrapper",
                "FirebaseStorageWrapper",
                "FirebaseCoreWrapper"
            ]
        ),

        // =======================================================
        // 2. BINARY POOL
        // =======================================================
        .binaryTarget(name: "FirebaseCoreBinary", path: "Frameworks/FirebaseCore.xcframework"),
        .binaryTarget(name: "FirebaseCoreInternalBinary", path: "Frameworks/FirebaseCoreInternal.xcframework"),
        .binaryTarget(name: "FirebaseInstallationsBinary", path: "Frameworks/FirebaseInstallations.xcframework"),
        .binaryTarget(name: "GoogleUtilitiesBinary", path: "Frameworks/GoogleUtilities.xcframework"),
        .binaryTarget(name: "nanopbBinary", path: "Frameworks/nanopb.xcframework"),
        .binaryTarget(name: "FBLPromisesBinary", path: "Frameworks/FBLPromises.xcframework"),
        .binaryTarget(name: "PromisesBinary", path: "Frameworks/Promises.xcframework"),
        .binaryTarget(name: "FirebaseSharedSwiftBinary", path: "Frameworks/FirebaseSharedSwift.xcframework"),
        .binaryTarget(name: "FirebaseAnalyticsBinary", path: "Frameworks/FirebaseAnalytics.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurementBinary", path: "Frameworks/GoogleAppMeasurement.xcframework"),
        .binaryTarget(name: "GoogleAppMeasurementIdentitySupportBinary", path: "Frameworks/GoogleAppMeasurementIdentitySupport.xcframework"),
        .binaryTarget(name: "FirebaseCrashlyticsBinary", path: "Frameworks/FirebaseCrashlytics.xcframework"),
        .binaryTarget(name: "FirebaseSessionsBinary", path: "Frameworks/FirebaseSessions.xcframework"),
        .binaryTarget(name: "FirebaseCoreExtensionBinary", path: "Frameworks/FirebaseCoreExtension.xcframework"),
        .binaryTarget(name: "GoogleDataTransportBinary", path: "Frameworks/GoogleDataTransport.xcframework"),
        .binaryTarget(name: "FirebaseRemoteConfigBinary", path: "Frameworks/FirebaseRemoteConfig.xcframework"),
        .binaryTarget(name: "FirebaseRemoteConfigInteropBinary", path: "Frameworks/FirebaseRemoteConfigInterop.xcframework"),
        .binaryTarget(name: "FirebaseABTestingBinary", path: "Frameworks/FirebaseABTesting.xcframework"),
        .binaryTarget(name: "FirebaseMessagingBinary", path: "Frameworks/FirebaseMessaging.xcframework"),
        .binaryTarget(name: "FirebaseMessagingInteropBinary", path: "Frameworks/FirebaseMessagingInterop.xcframework"),
        .binaryTarget(name: "FirebaseStorageBinary", path: "Frameworks/FirebaseStorage.xcframework"),
        .binaryTarget(name: "GTMSessionFetcherBinary", path: "Frameworks/GTMSessionFetcher.xcframework"),
        .binaryTarget(name: "FirebaseAppCheckInteropBinary", path: "Frameworks/FirebaseAppCheckInterop.xcframework"),
        .binaryTarget(name: "FirebaseAuthInteropBinary", path: "Frameworks/FirebaseAuthInterop.xcframework")
    ]
)
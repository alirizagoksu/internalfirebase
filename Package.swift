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
        // 2. BINARY POOL (Release 12.6.1)
        // =======================================================
        .binaryTarget(
            name: "FirebaseCoreBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCore.xcframework.zip",
            checksum: "c6acd60fc033005943b6b3a65068be81fe2675d67fca2de8932e271718194f97"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternalBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCoreInternal.xcframework.zip",
            checksum: "f667e73ba815849cded4d8932d2fa39a0e95f02b9d3d75563840c936017ab5a9"
        ),
        .binaryTarget(
            name: "FirebaseInstallationsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseInstallations.xcframework.zip",
            checksum: "e1ef5eb568d265ec6a83e4ae8d95c45011450f8eddef7094f7069e5cbb97164b"
        ),
        .binaryTarget(
            name: "GoogleUtilitiesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleUtilities.xcframework.zip",
            checksum: "f60b3f547559e545fbc57316d2889afb0ccc904fc4c088729ec7424775b73157"
        ),
        .binaryTarget(
            name: "nanopbBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/nanopb.xcframework.zip",
            checksum: "d75ce7aa8a0ffd3a8669255f4d8f14baa26576f866f65b1da0b0d91a890a988b"
        ),
        .binaryTarget(
            name: "FBLPromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FBLPromises.xcframework.zip",
            checksum: "488c1d7300ec06ce95f5bf9e4bde292fc8932c07ba2a724bd645f2a5e215c1b4"
        ),
        .binaryTarget(
            name: "PromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/Promises.xcframework.zip",
            checksum: "fc6773bf83f0f7d4c1ecf923093d7ac66b4e2b94d786ab934899166e810c5d15"
        ),
        .binaryTarget(
            name: "FirebaseSharedSwiftBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseSharedSwift.xcframework.zip",
            checksum: "06c4aa895ec70c868e8a6bf7f1216be4087764fe71ce82b07f76eb85a365da93"
        ),
        .binaryTarget(
            name: "FirebaseAnalyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAnalytics.xcframework.zip",
            checksum: "63df9f58a41a2255ac82333375943879de08ceff4352262fd79d8a25dd5b7734"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleAppMeasurement.xcframework.zip",
            checksum: "6235104e882c07b3af654e240eb0d1110903065fd597fdbf9739e4f6edf11967"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleAppMeasurementIdentitySupport.xcframework.zip",
            checksum: "96ca98072f3d61a7e86556c685036500ee2a443b191148f2cbd0720919c8a136"
        ),
        .binaryTarget(
            name: "FirebaseCrashlyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCrashlytics.xcframework.zip",
            checksum: "a9ace737412f8356d42ebd2a04afdec8ea13f80059f3b7b7d22c1187e1333bc2"
        ),
        .binaryTarget(
            name: "FirebaseSessionsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseSessions.xcframework.zip",
            checksum: "12901804f53b921740179c34199496497c551f05707c20db07f16cf34ef7a44f"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtensionBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCoreExtension.xcframework.zip",
            checksum: "34ac91cd9f4de0317102baf6d82f99600bb62b22c59f9d68fde00210e78243da"
        ),
        .binaryTarget(
            name: "GoogleDataTransportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleDataTransport.xcframework.zip",
            checksum: "5232f6715712877b03ccab147a8d63fb4c539c4e671de14fb0986da7e4155a34"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseRemoteConfig.xcframework.zip",
            checksum: "9c9ae26aefc89691fe59cb5c7ec57dd1347965f8e1a6cf4fc4ab9e231baca043"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseRemoteConfigInterop.xcframework.zip",
            checksum: "5720037416c18da35cf9eb9893789d6ef2dca1566bb04869e93c98ae62491169"
        ),
        .binaryTarget(
            name: "FirebaseABTestingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseABTesting.xcframework.zip",
            checksum: "0553d5a10b818a39898e0bea6236417b18d66291e44440fe5d3b1c827f96d2a2"
        ),
        .binaryTarget(
            name: "FirebaseMessagingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseMessaging.xcframework.zip",
            checksum: "659cebaf17355cdd80dd75601e51f70827963e30ae6be6263ebf65cf1810123c"
        ),
        .binaryTarget(
            name: "FirebaseMessagingInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseMessagingInterop.xcframework.zip",
            checksum: "c9cdbece2058197b8d215c2b4e8a63162e35bbe6e8494eec70240b7ed254cdae"
        ),
        .binaryTarget(
            name: "FirebaseStorageBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseStorage.xcframework.zip",
            checksum: "403ff25a42aa3126a093c5716f5930f10b438d8e39664903c841ec3d2308e4a0"
        ),
        .binaryTarget(
            name: "GTMSessionFetcherBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GTMSessionFetcher.xcframework.zip",
            checksum: "8063e6825b4dc135a0b48316348689caa113b9d18a622f03b11de7ce31be8a9d"
        ),
        .binaryTarget(
            name: "FirebaseAppCheckInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAppCheckInterop.xcframework.zip",
            checksum: "89d6e1f30bc1664dcfb5eb70eea69ad2c6f1acad5ce5312050160fedf19f1d8e"
        ),
        .binaryTarget(
            name: "FirebaseAuthInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAuthInterop.xcframework.zip",
            checksum: "6c014c8c395109675fb6116521d2148c8b3afff055e84fb1c3405617caedfcaf"
        )
    ]
)
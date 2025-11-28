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
            checksum: "a17d978a6b4f6c79e9b06fa48ac6d64c6add869227dabd02311c50d2ea9802de"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternalBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCoreInternal.xcframework.zip",
            checksum: "9bdcc36aa8b78704d93912db392a89ed14e643667a64f3234ed3c30eb7b75550"
        ),
        .binaryTarget(
            name: "FirebaseInstallationsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseInstallations.xcframework.zip",
            checksum: "511597a3077bb9d0777ae170fa0dfce9f305f18083541bcea887b97be7ea4a98"
        ),
        .binaryTarget(
            name: "GoogleUtilitiesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleUtilities.xcframework.zip",
            checksum: "ec70dd221177b8a0151845a1c3782b71fe3baeefb0d8688da18ffed905dfba64"
        ),
        .binaryTarget(
            name: "nanopbBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/nanopb.xcframework.zip",
            checksum: "f75c5d89cfc62dda4666140bb8662291086d16aa6bb33468ad6d155afe8e4200"
        ),
        .binaryTarget(
            name: "FBLPromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FBLPromises.xcframework.zip",
            checksum: "2ec3f271a1915f2ed50414be8f7521afb6f3d2ff874b441f35708e92895641f4"
        ),
        .binaryTarget(
            name: "PromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/Promises.xcframework.zip",
            checksum: "c33964f239a0fa15feb13a09c5be29fc17065f405e1bdb2e95293b1f4c74ad34"
        ),
        .binaryTarget(
            name: "FirebaseSharedSwiftBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseSharedSwift.xcframework.zip",
            checksum: "d2479244a2ab0372cafbd61a2fd619750737cf247ab2455c2119c09935f61bce"
        ),
        .binaryTarget(
            name: "FirebaseAnalyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAnalytics.xcframework.zip",
            checksum: "6f6fd6ce53599806cb8302a313cb613508c8b5bad999fb4a0b6ad7959d6d8a19"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleAppMeasurement.xcframework.zip",
            checksum: "4c747cfc4f60719653489e2adae98d603d53abbf81233f383dd009bd0be7d1b1"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleAppMeasurementIdentitySupport.xcframework.zip",
            checksum: "ba48073fdd7cd1a76479374b39fd7709f101913771a99cffac41289a9fe5baa9"
        ),
        .binaryTarget(
            name: "FirebaseCrashlyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCrashlytics.xcframework.zip",
            checksum: "08f737af655d1b2ace674002e9b11c4375fbb1d3343ca2909e811f3b8aa11ba5"
        ),
        .binaryTarget(
            name: "FirebaseSessionsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseSessions.xcframework.zip",
            checksum: "dda26141dc34da995e6413c4c0abdad7d21bd4c41feb84a2e48472b786c29101"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtensionBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseCoreExtension.xcframework.zip",
            checksum: "8ed34c10741bc9aac376394c50cee9f9f9f70128e3fffb9a0dcc13407b3d1b7d"
        ),
        .binaryTarget(
            name: "GoogleDataTransportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GoogleDataTransport.xcframework.zip",
            checksum: "ecf4c8572a9a3f6a27d75ed9c6ab69ff65ce55aa62f101b52808b4b15429e245"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseRemoteConfig.xcframework.zip",
            checksum: "7674bd95737e622e80af627c44ce99f61457ca0609bac00c2ec310acadd17fde"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseRemoteConfigInterop.xcframework.zip",
            checksum: "1afa0c469b1059d5e804bf3f3bcd88fb4de3420a3eb60da6d236ac912113c493"
        ),
        .binaryTarget(
            name: "FirebaseABTestingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseABTesting.xcframework.zip",
            checksum: "453901085542b84a47ce4599971bba0afd9cddda515f41123cce340585324e30"
        ),
        .binaryTarget(
            name: "FirebaseMessagingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseMessaging.xcframework.zip",
            checksum: "9af897e1b88b22dac1b362aa19899719504235fa13846bb5ce1c05a793627676"
        ),
        .binaryTarget(
            name: "FirebaseMessagingInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseMessagingInterop.xcframework.zip",
            checksum: "0f04e87c28152258ba7d1b61ad4a08d977ad33c65c21a5e63f2e1ad6d8bf1e75"
        ),
        .binaryTarget(
            name: "FirebaseStorageBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseStorage.xcframework.zip",
            checksum: "7ee7252c19e07d287024faba9fea7d1de278365e16e02e544ddf2ef35120dac8"
        ),
        .binaryTarget(
            name: "GTMSessionFetcherBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/GTMSessionFetcher.xcframework.zip",
            checksum: "c4396c7c9158d74cbb3551f2fcef8d30c8dcb81365a984d0def0c1a714fb996d"
        ),
        .binaryTarget(
            name: "FirebaseAppCheckInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAppCheckInterop.xcframework.zip",
            checksum: "b2790ebd5f32d7610ba34f071f01c44e5f78d5b9371119c30d3997517cc39c4f"
        ),
        .binaryTarget(
            name: "FirebaseAuthInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.1/FirebaseAuthInterop.xcframework.zip",
            checksum: "fb354570f5c2d781d223e36f4a4a51cef7c951b2445b28c2b027a2f37660097f"
        )
    ]
)
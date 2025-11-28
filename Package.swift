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
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseCore.xcframework.zip",
            checksum: "7f0a3ec1517608ab9b0ea01185eea014337a1143382939102d8c9ece0d007b77"
        ),
        .binaryTarget(
            name: "FirebaseCoreInternalBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseCoreInternal.xcframework.zip",
            checksum: "eb211b6381a02cf23ac95bceb94ef5416c4c9a8b585ab6edf9c4376dc9b1cac3"
        ),
        .binaryTarget(
            name: "FirebaseInstallationsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseInstallations.xcframework.zip",
            checksum: "8cb49c3a0ecf656899c822e39d50ce59082c3ea3c39682ac01d70f9ed51ad808"
        ),
        .binaryTarget(
            name: "GoogleUtilitiesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/GoogleUtilities.xcframework.zip",
            checksum: "ec70dd221177b8a0151845a1c3782b71fe3baeefb0d8688da18ffed905dfba64"
        ),
        .binaryTarget(
            name: "nanopbBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/nanopb.xcframework.zip",
            checksum: "c5986310935e0e289ec1cca2ac31a854282a946f3708b3e542e476d51fc1efc3"
        ),
        .binaryTarget(
            name: "FBLPromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FBLPromises.xcframework.zip",
            checksum: "62bef62529a77b3abbc0238338e72c91c74413abbd10c9d4f550583d78b33504"
        ),
        .binaryTarget(
            name: "PromisesBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/Promises.xcframework.zip",
            checksum: "354d851a431e440084ed42bbaf546f301440236d138123a4c7bf12e6420d0532"
        ),
        .binaryTarget(
            name: "FirebaseSharedSwiftBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseSharedSwift.xcframework.zip",
            checksum: "4ed6ec590e9d685f9a13148c7867758e4c798235bb9fdf7f2156f6c24667dfa9"
        ),
        .binaryTarget(
            name: "FirebaseAnalyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseAnalytics.xcframework.zip",
            checksum: "7d3661ea65be1aaa74ae3b97d61486779b71689456bdd947a0aef28a9b506b85"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/GoogleAppMeasurement.xcframework.zip",
            checksum: "638cbb4a67ad9aa794f2c1363021d268fd494187c1250d53d575c75d0ed27fed"
        ),
        .binaryTarget(
            name: "GoogleAppMeasurementIdentitySupportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/GoogleAppMeasurementIdentitySupport.xcframework.zip",
            checksum: "67b3f99c6a9f2801e46fc66385e46249f03ada1e4bc3ffc9f06f8a125b79bf00"
        ),
        .binaryTarget(
            name: "FirebaseCrashlyticsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseCrashlytics.xcframework.zip",
            checksum: "468cdfee8051571c262d38d27078b6c1a61aba614162e983591ea1a209738766"
        ),
        .binaryTarget(
            name: "FirebaseSessionsBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseSessions.xcframework.zip",
            checksum: "7604a38ea00a901e52566e04127880170153152c785f6f4de65ba2854f16059b"
        ),
        .binaryTarget(
            name: "FirebaseCoreExtensionBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseCoreExtension.xcframework.zip",
            checksum: "868935b7edf23abd933d0c630b7bcf93bc4ce5aa8cc5eb331917d4eb90a5ce50"
        ),
        .binaryTarget(
            name: "GoogleDataTransportBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/GoogleDataTransport.xcframework.zip",
            checksum: "4cfe3f816debd4340517013d0d3c66312cad1d942751ba42c250fb09a3fa2410"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseRemoteConfig.xcframework.zip",
            checksum: "db7733d1040b004e2f9702e9961d1e55c76e94fcfd2e073c4238b722b6b5031b"
        ),
        .binaryTarget(
            name: "FirebaseRemoteConfigInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseRemoteConfigInterop.xcframework.zip",
            checksum: "1afa0c469b1059d5e804bf3f3bcd88fb4de3420a3eb60da6d236ac912113c493"
        ),
        .binaryTarget(
            name: "FirebaseABTestingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseABTesting.xcframework.zip",
            checksum: "8f1eac97629cc01effecf9e82e8f9fb3b93808775b2404833112e1d5a931bc59"
        ),
        .binaryTarget(
            name: "FirebaseMessagingBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseMessaging.xcframework.zip",
            checksum: "f9cbbeb7487f82a6dfcd5c232493a899b558b834c4c794f1a97ef416d41a053a"
        ),
        .binaryTarget(
            name: "FirebaseMessagingInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseMessagingInterop.xcframework.zip",
            checksum: "7fe0b8e65a8d36c69798faacab23a35bfee7526d546403f9aee18e42a853300a"
        ),
        .binaryTarget(
            name: "FirebaseStorageBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseStorage.xcframework.zip",
            checksum: "30fccad9a3edf09307a07b305072f7ab336db1bc796355f3ab18234cb5aebde7"
        ),
        .binaryTarget(
            name: "GTMSessionFetcherBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/GTMSessionFetcher.xcframework.zip",
            checksum: "c4396c7c9158d74cbb3551f2fcef8d30c8dcb81365a984d0def0c1a714fb996d"
        ),
        .binaryTarget(
            name: "FirebaseAppCheckInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseAppCheckInterop.xcframework.zip",
            checksum: "8324dcb670ae936f871ecd57b25143832eac39b5b5655e5dcd4bb40a352096f2"
        ),
        .binaryTarget(
            name: "FirebaseAuthInteropBinary",
            url: "https://github.com/alirizagoksu/internalfirebase/releases/download/12.6.5/FirebaseAuthInterop.xcframework.zip",
            checksum: "2d5b92cb527ae27f11ba9dec5da5fad70ee707e35387ffe2e1931796b1bebcf6"
        )
    ]
)
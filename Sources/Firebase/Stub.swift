// Sources/FirebaseAllInOne/Stub.swift

import Foundation

// Wrapper'ları export ediyoruz ki içlerindeki ayarlar gelsin
@_exported import FirebaseAnalyticsWrapper
@_exported import FirebaseCrashlyticsWrapper
@_exported import FirebaseRemoteConfigWrapper
@_exported import FirebaseMessagingWrapper
@_exported import FirebaseStorageWrapper
@_exported import FirebaseSessionsWrapper
@_exported import FirebaseCoreWrapper

// Garanti olsun diye orijinal binary modül isimlerini de export edebiliriz
// (Wrapper'lar zaten ediyor ama AllInOne'da explicit olmak bazen autocomplete'i hızlandırır)
@_exported import FirebaseCore
@_exported import FirebaseAnalytics
@_exported import FirebaseCrashlytics
@_exported import FirebaseRemoteConfig
@_exported import FirebaseMessaging
@_exported import FirebaseStorage
@_exported import FirebaseSessions

import Foundation

// @_exported anahtar kelimesi, bu kütüphaneyi import edene
// aşağıdaki kütüphaneleri de "hediye" eder.

// 1. Binary'nin içindeki orijinal modül ismini dışarı açıyoruz
@_exported import FirebaseAnalytics

// 2. Analytics kullanan Core'a da ihtiyaç duyar, onu da açıyoruz
@_exported import FirebaseCore
// Not: Eğer Core'u "FirebaseCoreWrapper" içinde sarmaladıysan,
// o modülün içindeki Stub'da da Core binary'si export edilmeli.

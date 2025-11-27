# InternalFirebase

Bu proje, Firebase kütüphanelerini (Analytics, Crashlytics, RemoteConfig, vb.) tek bir çatı altında toplayan ve yöneten dahili bir Swift Package'dır.

## Gereksinimler

- iOS 13.0+
- Xcode 15.0+
- Swift 5.9+

## Kurulum

Bu paketi projenize eklemek için Swift Package Manager kullanabilirsiniz.

### Xcode ile Ekleme

1. Xcode'da **File > Add Package Dependencies...** menüsünü açın.
2. Arama çubuğuna bu reponun URL'sini veya yerel yolunu yapıştırın.
3. İhtiyacınız olan kütüphaneleri seçin (örn: `FirebaseAnalyticsWrapper`, `FirebaseCrashlyticsWrapper`).

### Package.swift ile Ekleme

`Package.swift` dosyanıza aşağıdaki gibi ekleyebilirsiniz:

```swift
dependencies: [
    .package(path: "../InternalFirebase") // Yerel yol
    // veya
    // .package(url: "git@github.com:sirket/InternalFirebase.git", from: "1.0.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "FirebaseAnalytics", package: "InternalFirebase"),
            .product(name: "FirebaseCrashlytics", package: "InternalFirebase"),
            // ...
        ]
    )
]
```

## Lokalde Test Etme (Sample App)

Bu paketi denemek için `Examples/SampleApp` klasöründeki örnek projeyi kullanabilirsiniz.

1. `Examples/SampleApp/Package.swift` dosyasını Xcode ile açın.
2. Scheme olarak `SampleApp`'i seçin.
3. Bir simülatör seçip çalıştırın (Cmd+R).

## İçerik

Paket aşağıdaki modülleri içerir:

- **FirebaseAnalytics**: Analitik olaylarını toplamak için.
- **FirebaseCrashlytics**: Çökme raporlarını toplamak için.
- **FirebaseRemoteConfig**: Uzaktan konfigürasyon yönetimi için.
- **FirebaseMessaging**: Push bildirimleri için.
- **FirebaseStorage**: Dosya depolama işlemleri için.
- **FirebaseSessions**: Oturum yönetimi için.

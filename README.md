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
3. İhtiyacınız olan kütüphaneleri seçin (örn: `FirebaseAnalytics`, `FirebaseCrashlytics`).

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

## Lokalde Test Etme

Bu paketi denemek için iki yöntem var:

### 1. Xcode ile Example App (Önerilen)

1. `Examples/SampleApp/Package.swift` dosyasını Xcode ile açın **veya**
2. Ana proje klasöründeki `Package.swift`'i açıp SampleApp scheme'ini seçin
3. Bir iOS simülatör seçin (iPhone 15, iPhone 14, vs.)
4. Cmd+R ile çalıştırın

> **Not**: `-ObjC` linker flag'i Firebase için kritiktir. Xcode bu flag'i düzgün handle eder, `swift build` komutu ile build sorun çıkarabilir.

### 2. Kendi Projenize Ekleme

Kendi iOS projenize SPM üzerinden ekleyebilirsiniz:
- Xcode'da **File > Add Package Dependencies > Add Local**
- Bu projenin bulunduğu klasörü seçin (örn: masaüstünüzde veya başka bir konumda)
- İhtiyacınız olan modülleri (FirebaseAnalytics, FirebaseCrashlytics, vs.) ekleyin

## İçerik

Paket aşağıdaki modülleri içerir:

- **FirebaseAnalytics**: Analitik olaylarını toplamak için.
- **FirebaseCrashlytics**: Çökme raporlarını toplamak için.
- **FirebaseRemoteConfig**: Uzaktan konfigürasyon yönetimi için.
- **FirebaseMessaging**: Push bildirimleri için.
- **FirebaseStorage**: Dosya depolama işlemleri için.
- **FirebaseSessions**: Oturum yönetimi için.

# SPM Collection Git LFS Sorunu ve Çözümler

## Sorun

SPM Collection kullanırken şu hatayı alıyorsunuz:
```
Couldn't check out revision '07ac2f7...'
Couldn't unexpectedly did not find the new dependency in the package graph
```

**Temel Sebep**: Git LFS (Large File Storage) ile XCFramework dosyaları saklanıyor. SPM Collection generate işlemi sırasında Git LFS dosyaları düzgün indirilmiyor.

`.gitattributes` dosyasında:
```
*.xcframework filter=lfs diff=lfs merge=lfs -text
*.a filter=lfs diff=lfs merge=lfs -text
```

## Çözüm Seçenekleri

### Seçenek 1: SPM Collection Olmadan Doğrudan Kullanım (Önerilen)

SPM Collection kullanmadan paketi doğrudan ekleyin:

1. Xcode'da **File > Add Package Dependencies**
2. GitHub URL'ini girin: `https://github.com/alirizagoksu/internalfirebase.git`
3. Version: `12.6.0` seçin veya `main` branch kullanın
4. İhtiyacınız olan modülleri seçin

Bu yöntem Git LFS sorununu bypass eder çünkü Xcode paketi doğrudan clone ediyor.

### Seçenek 2: Git LFS'i Devre Dışı Bırak (Risk: Büyük Dosyalar)

> ⚠️ **UYARI**: XCFramework dosyaları çok büyük (toplam ~2-3 GB). Bu yöntem repo boyutunu çok artırır ve GitHub'ın ücretsiz limitlerini aşabilir.

```bash
# Git LFS'i kaldır
git lfs uninstall
rm .gitattributes

# Tüm LFS tracked dosyaları normal git dosyalarına dönüştür
git lfs migrate export --include="*.xcframework,*.a,Scripts/run,Scripts/upload-symbols" --everything

# Yeni commit
git add -A
git commit -m "Remove Git LFS, convert to regular files"

# Yeni tag
git tag -d 12.6.0
git tag 12.6.1
git push origin main --force
git push origin 12.6.1
```

### Seçenek 3: Binary-Only XCFramework Paketleri (En Temiz)

Her bir Firebase modülünü ayrı bir binary package olarak dağıtın:

1. Her XCFramework için ayrı bir repo oluşturun
2. Sadece o framework'ü içeren minimal bir Package.swift ekleyin
3. Ana pakette bunları binaryTarget olarak referans edin

**장점**: 
- Git LFS gerekmez
- Her framework bağımsız versiyonlanır
- Repo boyutu küçük kalır

**Dezavantaj**: Daha fazla repo yönetimi

### Seçenek 4: SPM Collection'ı Manuel Düzelt

Collection JSON dosyanızda Git LFS clone ayarlarını eklemeyi deneyin (deneysel):

```json
{
  "collections": [
    {
      "name": "InternalFirebase",
      "packages": [
        {
          "url": "https://github.com/alirizagoksu/internalfirebase.git",
          "version": {
            "exact": "12.6.0"
          }
        }
      ]
    }
  ]
}
```

## Önerilen Çözüm

**Seçenek 1**'i kullanın: SPM Collection olmadan doğrudan paket ekleyin. Bu en hızlı ve güvenilir yöntemdir.

Eğer mutlaka SPM Collection kullanmanız gerekiyorsa, **Seçenek 3** (Binary-only packages) en profesyonel yaklaşımdır ama daha fazla kurulum gerektirir.

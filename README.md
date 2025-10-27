# Kendin Yap Mobil

No-code mobil uygulama üreticisi (Flutter ile geliştirilmiş).

## Özellikler

- 🎨 Sürükle-bırak editör
- 🎯 Guided Mode (aşama aşama)
- 🚀 OTA (Over-The-Air) yayınlama
- 🔐 Multi-tenant proje sistemi
- 🎭 Tema desteği
- 📦 Component library
- ⚡ Gerçek zamanlı önizleme

## Kurulum

```bash
flutter pub get
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Çalıştırma

```bash
# Dev
flutter run --dart-define=ENV=dev

# Prod
flutter run --dart-define=ENV=prod
```

## Yapı

```
lib/
├── core/           # Temel modüller (routing, theme, di)
├── shared/         # Paylaşılan widget'lar ve servisler
├── features/       # Feature'lar (auth, builder, runtime, publish)
└── l10n/           # Yerelleştirme
```

## Lisans

MIT


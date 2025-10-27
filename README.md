# 🚀 Uygulamatör - No-Code Mobil Uygulama Geliştirme Platformu

Kod yazmadan Android ve iOS için mobil uygulama geliştiren, sürükle-bırak editör platformu.

## ✨ Özellikler

### 🎨 Görsel Editör
- **Sürükle-Bırak Editör**: Bileşenleri sürükleyip canvas'a bırakın
- **Header/Body/Footer Slot Sistemi**: Üç ayrı bölgeye bileşen ekleyin
- **Canlı Önizleme**: Değişiklikleri anında görün
- **Özellikler Paneli**: Bileşen ayarlarını kolayca yapın

### 📱 Hazır Şablonlar
- 🛒 **E-Ticaret**: Ürün vitrinli mağaza
- 📰 **Blog**: İçerik ve makale sitesi  
- 🔐 **Giriş Sayfası**: Kayıt/Giriş ekranları
- 🎯 **Landing**: Tanıtım sayfası
- ⚪ **Boş Şablon**: Sıfırdan başlayın

### 🎨 Tema ve Tasarım
- **5 Hazır Renk**: Mor, Yeşil, Mavi, Kırmızı, Turuncu
- **Dark Mode**: Karanlık tema desteği
- **Renk Seçici**: Özel renk paleti
- **Otomatik Tema**: Sistem temasını takip eder

### 🧩 Bileşenler
- Text (Metin)
- Button (Buton)
- Image (Görsel)
- Card (Kart)
- List (Liste)
- Search (Arama)
- Notification (Bildirim)
- Form Elements (Form Alanları)

### 📊 Özellikler
- **Mock Data**: Örnek veri ile test
- **Analytics**: Olay takibi
- **Bildirim Sistemi**: Push bildirimleri
- **Medya Kütüphanesi**: Görsel yönetimi
- **OTA Yayınlama**: Kod yazmadan güncelleme
- **Çok Sayfa Yönetimi**: Birden fazla sayfa oluşturun

## 📋 Gereksinimler

- Flutter 3.0+
- Dart 3.0+
- Android SDK / Xcode
- Supabase hesabı (Opsiyonel - Backend için)

## 🚀 Kurulum

```bash
# Repoyu klonlayın
git clone https://github.com/Erayy394/mobil-uygulama-gelistirme-uygulamator.git
cd kendinyapmobil

# Bağımlılıkları yükleyin
flutter pub get

# Uygulamayı çalıştırın
flutter run
```

## 🎯 Kullanım

### 1. Kayıt/Giriş
- E-posta ve şifre ile kayıt olun
- Google/Apple ile giriş (yakında)

### 2. Proje Oluştur
- Yeni proje başlatın
- Tema ve renk seçin

### 3. Sayfa Düzenle
- Sol panelden bileşen seçin
- Header/Body/Footer'a ekleyin
- Özellikleri sağ panelden düzenleyin

### 4. Şablon Kullan
- Hazır şablonlardan birini seçin
- Otomatik bileşenler eklenir

### 5. Yayınla
- Önizleme ile kontrol edin
- Kaydet ve yayınla
- OTA ile güncelle

## 📱 Android Derleme

```bash
flutter build apk --release
flutter install
```

## 🔧 Geliştirme

```bash
# Freezed kodu oluştur
flutter pub run build_runner watch

# Test çalıştır
flutter test
```

## 📂 Proje Yapısı

```
lib/
├── core/                 # Temel yapı
│   ├── routing/          # Router
│   ├── theme/            # Tema
│   └── utils/            # Yardımcılar
├── features/
│   ├── auth/             # Kimlik doğrulama
│   ├── builder/          # Editör
│   ├── runtime/          # Çalışma zamanı
│   └── publish/          # Yayınlama
└── shared/               # Paylaşılan kodlar
```

## 🛠️ Teknolojiler

- **Flutter**: Cross-platform framework
- **GoRouter**: Navigation
- **Riverpod**: State management
- **Freezed**: Immutability
- **Supabase**: Backend (opsiyonel)
- **JSON**: DSL Schema

## 📄 Lisans

MIT License - Detaylar için LICENSE dosyasına bakın.

## 👨‍💻 Geliştirici

**Eray YEŞİLYURT**  
GitHub: [@Erayy394](https://github.com/Erayy394)

## 🤝 Katkıda Bulunma

1. Fork edin
2. Branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'feat: Yeni özellik eklendi'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📞 İletişim

- GitHub Issues: [Sorun bildir](https://github.com/Erayy394/mobil-uygulama-gelistirme-uygulamator/issues)
- Discussions: [Tartışma başlat](https://github.com/Erayy394/mobil-uygulama-gelistirme-uygulamator/discussions)

## 🌟 Yıldız Verin!

Bu projeyi beğendiyseniz yıldız vermeyi unutmayın! ⭐

---

**Uygulamatör** - Kod yazmadan mobil uygulama geliştirin! 🚀

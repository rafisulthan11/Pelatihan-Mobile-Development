# Aplikasi Catatan Rahasia 📝🔒

Aplikasi catatan pribadi yang aman dengan perlindungan PIN untuk menjaga privasi catatan Anda.

## ✨ Fitur Utama

- **🔐 Autentikasi PIN**: Keamanan berlapis dengan sistem PIN untuk melindungi catatan pribadi
- **📝 Manajemen Catatan**: Tambah, edit, dan hapus catatan dengan mudah
- **💾 Penyimpanan Lokal**: Data tersimpan aman di perangkat menggunakan SQLite
- **📱 Antarmuka User-Friendly**: Desain yang bersih dan mudah digunakan
- **🔄 Real-time Updates**: Perubahan catatan langsung tersinkronisasi
- **📅 Timestamp**: Setiap catatan memiliki waktu pembuatan dan pembaruan

## 🛠️ Teknologi yang Digunakan

- **Framework**: Flutter
- **Bahasa**: Dart
- **Database**: SQLite (via sqflite)
- **Penyimpanan**: SharedPreferences untuk pengaturan PIN
- **Platform**: Android, iOS, Web

### Dependencies

```yaml
dependencies:
  flutter: ^3.9.0
  sqflite: ^2.4.2 # Database lokal
  shared_preferences: ^2.5.3 # Penyimpanan preferensi
  path: ^1.9.1 # Manajemen path file
  cupertino_icons: ^1.0.8 # Icon iOS
```

## 📱 Screenshot dan Fitur

### 1. Halaman Login PIN

- Input PIN untuk akses pertama kali (membuat PIN baru)
- Verifikasi PIN untuk akses selanjutnya
- Tombol show/hide PIN untuk keamanan

### 2. Halaman Utama Catatan

- Daftar semua catatan dengan tanggal pembuatan
- Floating Action Button untuk menambah catatan baru
- Tombol logout di AppBar
- Preview konten catatan

### 3. Fitur CRUD Catatan

- **Create**: Dialog untuk menambah catatan baru dengan judul dan isi
- **Read**: Tampilan daftar catatan dengan preview
- **Update**: Edit catatan dengan dialog yang sama seperti tambah
- **Delete**: Konfirmasi hapus catatan dengan dialog

## 🚀 Instalasi dan Menjalankan Aplikasi

### Prasyarat

- Flutter SDK (versi 3.9.0 atau lebih baru)
- Android Studio / VS Code
- Android SDK untuk development Android
- Xcode untuk development iOS (khusus macOS)

### Langkah Instalasi

1. **Clone repository**

   ```bash
   git clone <repository-url>
   cd flutter_catatan_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Jalankan aplikasi**
   ```bash
   flutter run
   ```

### Build untuk Release

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

**Web:**

```bash
flutter build web
```

## 📁 Struktur Project

```
lib/
├── main.dart                 # Entry point aplikasi
├── data/
│   ├── database_local.dart   # Kelas untuk manajemen database SQLite
│   ├── note.dart            # Model data catatan
│   └── pin_service.dart     # Service untuk manajemen PIN
└── pages/
    ├── home_page.dart       # Halaman utama daftar catatan
    └── pin_page.dart        # Halaman login dengan PIN
```

## 🔧 Konfigurasi

### Database Schema

Database SQLite dengan tabel `notes`:

```sql
CREATE TABLE notes(
  id TEXT PRIMARY KEY,
  title TEXT,
  content TEXT,
  createdAt TEXT,
  updatedAt TEXT
)
```

### Permissions (Android)

Aplikasi menggunakan permission berikut di `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

## 🔒 Keamanan

- **PIN Protection**: Semua catatan terlindungi dengan PIN
- **Local Storage**: Data tersimpan lokal di perangkat, tidak dikirim ke server
- **Session Management**: Status login disimpan secara aman
- **Data Encryption**: SQLite menyediakan enkripsi tingkat database

## 🎯 Cara Menggunakan

1. **Pertama kali buka aplikasi**: Buat PIN baru (4 digit angka)
2. **Login selanjutnya**: Masukkan PIN yang sudah dibuat
3. **Tambah catatan**: Klik tombol "Tambah Catatan" dan isi judul serta konten
4. **Edit catatan**: Tap pada catatan yang ingin diedit
5. **Hapus catatan**: Klik icon delete (🗑️) pada catatan
6. **Logout**: Klik icon logout di AppBar untuk keluar

## 🛡️ Fitur Keamanan Lanjutan

- Validasi input PIN (hanya menerima angka)
- Konfirmasi dialog untuk aksi penting (hapus, logout)
- Auto-logout saat aplikasi ditutup
- Proteksi dari akses tidak sah

## 🐛 Troubleshooting

### Masalah Umum:

1. **Build error pada Android**

   ```bash
   flutter clean
   flutter pub get
   cd android && ./gradlew clean && cd ..
   flutter run
   ```

2. **Database tidak terbaca**

   - Hapus aplikasi dari perangkat
   - Install ulang untuk reset database

3. **PIN terlupa**
   - Hapus data aplikasi dari pengaturan perangkat
   - Atau hapus aplikasi dan install ulang

## 📝 Development Notes

- Aplikasi menggunakan Material Design untuk konsistensi UI
- Responsive design untuk berbagai ukuran layar
- Error handling yang komprehensif
- State management menggunakan StatefulWidget

## 🤝 Kontribusi

Silakan berkontribusi untuk meningkatkan aplikasi ini:

1. Fork repository
2. Buat branch fitur (`git checkout -b fitur-baru`)
3. Commit perubahan (`git commit -am 'Tambah fitur baru'`)
4. Push ke branch (`git push origin fitur-baru`)
5. Buat Pull Request

## 📄 Lisensi

Project ini dikembangkan untuk tujuan pembelajaran dan pengembangan skill Flutter.

## 👨‍💻 Developer

Dikembangkan dengan ❤️ menggunakan Flutter

---

**Catatan**: Aplikasi ini dirancang untuk pembelajaran pengembangan Flutter dengan fokus pada keamanan data lokal dan manajemen state yang baik.

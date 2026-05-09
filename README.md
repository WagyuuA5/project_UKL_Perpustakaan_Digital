SmartLibrary - Digital Library App 📚
SmartLibrary adalah aplikasi perpustakaan digital berbasis mobile yang dibangun menggunakan Flutter. Proyek ini merupakan tugas UKL (Uji Kenaikan Level) Semester 1 di SMK Telkom Malang. Aplikasi ini dirancang untuk mensimulasikan proses peminjaman buku dengan antarmuka yang modern dan bersih.

📂 Struktur Folder Proyek
Proyek ini diorganisir menggunakan pendekatan fungsional yang memisahkan antara logika bisnis (controllers), model data, komponen antarmuka (views), dan widget kustom agar kode lebih mudah dikelola.

Plaintext
lib/
├── controllers/          # Logika bisnis & manajemen state
│   ├── auth_controller.dart    # Menangani login & registrasi
│   ├── book_controller.dart    # Manajemen daftar buku
│   └── borrow_controller.dart  # Logika peminjaman buku
├── models/               # Struktur data & Blueprint objek
│   ├── book_model.dart         # Model data utama untuk Buku
│   ├── book_card.dart          # Data penunjang tampilan kartu
│   └── book_detail_view.dart   # Model untuk detail informasi
├── theme/                # Pengaturan visual aplikasi
│   └── app_theme.dart          # Konfigurasi warna, font, & gaya (Dark/Light Mode)
├── views/                # Halaman utama aplikasi (UI)
│   ├── splash_screen.dart      # Tampilan awal saat aplikasi dibuka
│   ├── login_view.dart         # Halaman autentikasi masuk
│   ├── RegisterScreen.dart     # Halaman pendaftaran akun baru
│   ├── home_view.dart          # Dashboard/Beranda koleksi buku
│   ├── LinimasaView.dart       # Daftar riwayat/status buku
│   └── profile_view.dart       # Informasi pengguna & pengaturan
├── widgets/              # Komponen UI yang dapat digunakan kembali
│   ├── app_button.dart         # Kustomisasi tombol utama
│   ├── app_textfield.dart      # Kustomisasi input teks
│   └── modal_helper.dart       # Komponen pop-up/bottom sheet (Tambah Buku)
└── main.dart             # Titik masuk utama (Entry Point) aplikasi
✨ Fitur Utama
Sistem Autentikasi: Alur lengkap dari Splash Screen menuju Login atau Register.

Manajemen Buku: Menampilkan daftar buku populer dan kategori di Home.

Linimasa & Status: Memantau buku yang tersedia (In Stock) atau yang sedang dipinjam (Borrowed).

Tambah Buku Baru: Input data buku secara dinamis melalui Modal Bottom Sheet.

Profil Pengguna: Halaman profil yang mendukung fitur estetika seperti Mode Gelap dan riwayat pinjam.

📝 Catatan Pembelajaran & Refleksi
Proyek SmartLibrary ini merupakan tonggak pencapaian pertama saya di semester satu SMK Telkom Malang. Sebagai seorang pemula yang baru mengenal dunia pemrograman, proyek ini bukan sekadar tugas untuk memenuhi syarat kenaikan level, melainkan sebuah proses eksplorasi mendalam terhadap ekosistem Dart dan framework Flutter.

Langkah Awal di Dunia Mobile Development
Melalui proyek ini, saya belajar memahami bagaimana sebuah aplikasi mobile disusun dari nol. Mulai dari memahami konsep Widget (semua adalah widget di Flutter), mengatur tata letak (layouting) menggunakan Row, Column, dan ListView, hingga mencoba mengimplementasikan pemisahan kode menggunakan folder controllers dan models. Meskipun masih menggunakan data statis/dummy, hal ini memberikan gambaran nyata tentang bagaimana aliran data (data flow) bekerja dalam sebuah aplikasi.

Keterbatasan dan Tantangan
Saya menyadari bahwa sebagai proyek pembelajaran awal, aplikasi ini masih memiliki banyak kekurangan, di antaranya:

Database: Belum adanya integrasi database real-time (seperti Firebase atau SQLite). Data akan kembali ke semula jika aplikasi di-restart.

State Management: Pengelolaan data masih sangat sederhana dan belum menggunakan library canggih seperti Provider, Bloc, atau GetX yang lebih efisien untuk skala besar.

Validasi: Sistem autentikasi masih bersifat simulasi dan belum memiliki validasi keamanan yang ketat.

Efisiensi Kode: Masih banyak kode yang mungkin bisa di-refactor agar lebih ringkas dan mengikuti prinsip DRY (Don't Repeat Yourself).

Harapan ke Depan
Meskipun masih "sederhana", proyek ini adalah bukti nyata keberanian saya untuk mulai menulis baris demi baris kode Dart. Kesalahan-kesalahan yang saya temukan selama proses debugging adalah guru terbaik yang mengajarkan saya cara berpikir logis. Ke depannya, saya berkomitmen untuk terus meningkatkan proyek ini dengan menambahkan fitur API, penyimpanan lokal yang permanen, dan animasi yang lebih halus seiring dengan bertambahnya pengetahuan saya di semester-semester berikutnya.

🛠️ Cara Menjalankan Project
Clone repositori ini.

Pastikan Flutter SDK sudah terinstal.

Jalankan flutter pub get di terminal.

Hubungkan emulator atau perangkat fisik, lalu jalankan flutter run.

Dibuat dengan semangat belajar oleh Wahyu Ravi Anggoro (XI RPL 7 - SMK Telkom Malang)

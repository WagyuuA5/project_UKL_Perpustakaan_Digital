
📚 SmartLibrary - Digital Library App
SmartLibrary adalah aplikasi perpustakaan digital berbasis mobile yang dibangun menggunakan framework Flutter. Proyek ini merupakan tugas UKL (Uji Kenaikan Level) Semester 1 di SMK Telkom Malang. Aplikasi ini dirancang untuk mensimulasikan proses peminjaman buku dengan antarmuka yang modern, responsif, dan bersih.

📂 Struktur Folder Proyek
Proyek ini menggunakan pendekatan fungsional (MVC-like) untuk memisahkan logika bisnis dengan tampilan agar kode lebih maintainable.

lib/
├── controllers/          # Logika bisnis & manajemen state
│   ├── auth_controller.dart    # Login & registrasi
│   ├── book_controller.dart    # Manajemen daftar buku
│   └── borrow_controller.dart  # Logika peminjaman
├── models/               # Blueprint data
│   ├── book_model.dart         # Model data utama Buku
│   ├── book_card.dart          # Data penunjang UI kartu
│   └── book_detail_view.dart   # Model detail informasi
├── theme/                # Styling Global
│   └── app_theme.dart          # Konfigurasi Dark/Light Mode
├── views/                # Halaman Utama (UI)
│   ├── splash_screen.dart      # Loading screen awal
│   ├── login_view.dart         # Form masuk
│   ├── RegisterScreen.dart     # Form daftar
│   ├── home_view.dart          # Dashboard koleksi
│   ├── LinimasaView.dart       # Riwayat & status buku
│   └── profile_view.dart       # Profil & pengaturan
├── widgets/              # Komponen Reusable
│   ├── app_button.dart         # Tombol kustom
│   ├── app_textfield.dart      # Input field kustom
│   └── modal_helper.dart       # Modal Bottom Sheet (Tambah Buku)
└── main.dart             # Entry Point Aplikasi

✨ Fitur UtamaFiturDeskripsiSistem AutentikasiAlur lengkap mulai dari Splash Screen hingga Login/Register.Manajemen BukuMenampilkan daftar buku populer dan kategori pada halaman Home.Linimasa & StatusMonitoring stok buku secara real-time (In Stock atau Borrowed).Tambah BukuInput data buku baru secara dinamis melalui Modal Bottom Sheet.Profil & EstetikaHalaman profil dengan dukungan Dark Mode dan riwayat peminjaman.
📝 Catatan Pembelajaran
[!NOTE]
Langkah Awal di Dunia Mobile Development
Proyek ini adalah langkah pertama saya mengenal bahasa Dart. Meskipun masih menggunakan Dummy Data (belum terkoneksi database real-time seperti Firebase), fokus utama saya adalah memahami State Management sederhana dan User Interface yang baik.

Tantangan & Kekurangan:
Integrasi Database: Saat ini data masih bersifat sementara (akan hilang jika aplikasi ditutup).

Validasi Form: Masih perlu pengembangan untuk validasi email dan password yang lebih ketat.

Refactoring: Masih banyak bagian kode yang bisa dioptimalkan agar lebih efisien.

Ini adalah bukti proses belajar saya di semester satu. Saya berkomitmen untuk terus mengembangkan aplikasi ini seiring bertambahnya ilmu di SMK Telkom Malang.

🚀 Cara Menjalankan
Clone repositori ini.

Jalankan flutter pub get untuk mengunduh library.

Jalankan flutter run pada emulator atau perangkat asli.

Developed with ❤️ by Wahyu Ravi Anggoro

Tips Tambahan Biar Makin Keren:
Gunakan Gambar/Screenshot: Jangan lupa lampirkan screenshot aplikasi di bagian bawah fitur. Caranya: ![alt text](link_gambar.png).

Badge: Kamu bisa tambah badge Flutter di paling atas:
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)

Emoji: Gunakan emoji secukupnya agar tidak membosankan (seperti yang saya lakukan di atas).

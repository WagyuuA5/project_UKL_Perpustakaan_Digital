# 📚 SmartLibrary - Digital Library App
![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Status](https://img.shields.io/badge/Status-Learning--Project-orange?style=for-the-badge)

**SmartLibrary** adalah solusi perpustakaan digital modern yang dibangun dengan dedikasi tinggi sebagai proyek **UKL (Uji Kenaikan Level) Semester 1** di **SMK Telkom Malang**. Aplikasi ini menggabungkan estetika desain dengan logika pemrograman Dart yang terstruktur.
---

## 🛠️ Arsitektur Proyek (Clean Structure)
Aplikasi ini menerapkan pemisahan tugas menggunakan pola **MVC (Model-View-Controller)** agar kode lebih mudah dibaca dan dikembangkan.

```text
lib/
├── ⚙️ controllers/    # Business Logic (Auth, Book, Borrow)
├── 📄 models/         # Blueprint Data & Object Mapping
├── 🎨 theme/          # UI Styling & Theme Management
├── 🖼️ views/          # Halaman Utama Aplikasi
└── 🧩 widgets/        # Reusable UI Components
🔥 Fitur Unggulan
🔐 Smart Authentication: Transisi mulus dari Splash Screen ke sistem masuk/daftar.

📖 Book Management: Penjelajahan koleksi buku populer dengan rating interaktif.

⚡ Real-time Simulation: Status stok buku (In Stock/Borrowed) yang responsif.

📥 Dynamic Input: Tambah koleksi buku baru langsung melalui Interactive Bottom Sheet.

🌓 Adaptive UI: Dukungan penuh untuk Dark Mode demi kenyamanan mata pengguna.

📝 Refleksi & Catatan Pembelajaran
[!IMPORTANT]
"Setiap baris kode adalah langkah menuju keahlian."

Proyek ini adalah langkah pertama saya menyelami ekosistem Flutter. Sebagai siswa semester satu, saya belajar bahwa membuat aplikasi bukan hanya soal tampilan yang cantik, tapi juga tentang logika yang kuat dan struktur folder yang rapi.

Apa yang saya pelajari?

Fundamental bahasa pemrograman Dart.

Hierarki Widget di Flutter dan manajemen tata letak (Layouting).

Simulasi aliran data menggunakan Dummy Database.

Keterbatasan Saat Ini:
Meskipun proyek ini masih menggunakan data lokal (statis) dan belum terintegrasi dengan database cloud seperti Firebase, ini adalah fondasi penting bagi saya. Saya menyadari masih banyak celah untuk perbaikan, seperti validasi input yang lebih ketat dan integrasi API di masa depan. Namun, proyek ini membuktikan bahwa dengan ketekunan, konsep yang rumit bisa diubah menjadi aplikasi yang fungsional.

🚀 Cara Menjalankan
Clone: git clone https://github.com/WagyuuA5/project_UKL_Perpustakaan_Digital.git

Get Packages: flutter pub get

Run: flutter run

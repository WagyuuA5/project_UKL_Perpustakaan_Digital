// lib/views/profile_view.dart
import 'dart:async';
import 'package:flutter/material.dart';
import '../controllers/book_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  final BookController _controller = BookController();

  String _name = "Wahyu Ravi Anggoro";
  String _kelas = "XI RPL 7";

  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  String _language = "Bahasa Indonesia";

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoSlider();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // AUTO SLIDER
  void _startAutoSlider() {
    final carouselBooks = _controller.books.take(5).toList();

    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pageController.hasClients) return;

      setState(() {
        _currentPage =
            (_currentPage + 1) % carouselBooks.length;
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  // EDIT PROFILE POPUP
  void _showEditProfileDialog() {
    final nameController = TextEditingController(text: _name);
    final kelasController = TextEditingController(text: _kelas);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Edit Profil"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nama"),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: kelasController,
                decoration: const InputDecoration(labelText: "Kelas"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Batal"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text("Simpan"),
              onPressed: () {
                if (nameController.text.isEmpty ||
                    kelasController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text("Nama dan Kelas wajib diisi")),
                  );
                  return;
                }
                setState(() {
                  _name = nameController.text;
                  _kelas = kelasController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Profil berhasil diperbarui")),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // LOGOUT DENGAN KONFIRMASI
  void _logout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Anda yakin ingin logout?"),
        actions: [
          TextButton(
            child: const Text("Batal"),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: const Text("Logout"),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Anda telah logout")),
              );
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }

  // TOGGLE DARK MODE
  void _toggleDarkMode() {
    setState(() => _darkModeEnabled = !_darkModeEnabled);
  }

  // TOGGLE NOTIFIKASI
  void _toggleNotifications() {
    setState(() => _notificationsEnabled = !_notificationsEnabled);
  }

  void _changeLanguage() {
    setState(() {
      _language = _language == "Bahasa Indonesia"
          ? "English"
          : "Bahasa Indonesia";
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = _darkModeEnabled
        ? ThemeData.dark()
        : ThemeData.light();

    return Theme(
      data: theme,
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER PROFIL
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2979FF), Color(0xFF1E88E5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage("assets/images/foto_profil.jpg"),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _kelas,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Tombol Edit Profile
                    ElevatedButton(
                      onPressed: _showEditProfileDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 6),
                      ),
                      child: const Text("Edit Profil"),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // =================
              // PENGATURAN (SETTING)
              // =================
              const Text(
                "Pengaturan",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text("Notifikasi"),
                      secondary: const Icon(Icons.notifications),
                      value: _notificationsEnabled,
                      onChanged: (_) => _toggleNotifications(),
                    ),
                    const Divider(height: 0),
                    SwitchListTile(
                      title: const Text("Mode Gelap"),
                      secondary: const Icon(Icons.dark_mode),
                      value: _darkModeEnabled,
                      onChanged: (_) => _toggleDarkMode(),
                    ),
                    const Divider(height: 0),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text("Bahasa"),
                      trailing: Text(_language),
                      onTap: _changeLanguage,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // =================
              // RIWAYAT PINJAM (DENGAN DESAIN ELEGAN)
              // =================
              const Text(
                "Riwayat Pinjam",
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _controller.books.take(5).length,
                  itemBuilder: (_, index) {
                    final book = _controller.books[index];

                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Stack(
                            children: [
                              Image.asset(
                                book.posterPath,
                                width: 150,
                                height: 180,
                                fit: BoxFit.cover,
                              ),

                              // GRADIENT OVERLAY
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.7)
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // TEXT INFORMASI
                              Positioned(
                                bottom: 8,
                                left: 8,
                                right: 8,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      book.title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      book.author,
                                      style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 32),

              // =================
              // LOGOUT BUTTON
              // =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Logout",
                    style:
                        TextStyle(fontSize: 16, letterSpacing: 0.5),
                  ),
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

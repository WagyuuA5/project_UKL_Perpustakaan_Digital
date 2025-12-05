

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book_detail_view.dart';
import 'package:flutter_application_1/views/LinimasaView.dart';
import 'dart:async';
import '../models/book_model.dart'; 
import '../controllers/book_controller.dart'; 
import 'profile_view.dart';  

const Color primaryBlue = Color(0xFF007AFF); 
const Color lightBackground = Color(0xFFF0F2F5); 
const Color cardColor = Colors.white; 
const Color darkText = Color(0xFF1E1E1E); 
const Color secondaryGrey = Color(0xFF8E8E93); 
const Color ratingColor = Color(0xFFFFC107); 

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0; 
  final List<String> _notifications = []; 
  late final List<Widget> _views;
  
  @override
  void initState() {
    super.initState();
    _views = [
      HomeContent(
        onNotificationAdded: _addNotification,
      ), 
      const LinimasaView(), 
      const ProfileView(), 
    ];
  }
  void _addNotification(String message) {
    setState(() {
      _notifications.add(message);
      if (_notifications.length > 15) { 
        _notifications.removeAt(0); 
      }
    });
  }

  void _showNotificationList(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Notifikasi Terbaru"),
          content: SizedBox(
            width: double.maxFinite,
            child: _notifications.isEmpty
                ? const Center(child: Text("Tidak ada notifikasi baru."))
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = _notifications.length - 1 - index;
                      return ListTile(
                        leading: const Icon(Icons.check_circle, color: primaryBlue),
                        title: Text(_notifications[reversedIndex], style: const TextStyle(fontSize: 14)),
                        subtitle: const Text("Baru saja", style: TextStyle(fontSize: 12)),
                      );
                    },
                  ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Tutup"),
              onPressed: () {
                setState(() {
                  _notifications.clear(); 
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool showAppBar = _currentIndex == 0;

    return Scaffold(
      backgroundColor: lightBackground,
      
      appBar: showAppBar 
        ? AppBar(
            title: const Text("SmartLibrary", style: TextStyle(fontWeight: FontWeight.bold, color: primaryBlue)),
            backgroundColor: lightBackground,
            foregroundColor: darkText,
            elevation: 0,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () => _showNotificationList(context),
                    color: darkText,
                  ),
                  if (_notifications.isNotEmpty)
                    Positioned(
                      right: 11,
                      top: 11,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                        constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                        child: Text('${_notifications.length}', style: const TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                      ),
                    ),
                ],
              ),
            ],
          )
        : null, 
      
      body: _views[_currentIndex], 
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: primaryBlue,
      unselectedItemColor: secondaryGrey.withOpacity(0.8),
      type: BottomNavigationBarType.fixed,
      backgroundColor: cardColor,
      elevation: 10,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Beranda"),
        BottomNavigationBarItem(icon: Icon(Icons.timeline_outlined), label: "Linimasa"),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profil"),
      ],
      
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          if (index != 0) {
            FocusScope.of(context).unfocus(); 
          }
        });
      },
    );
  }
}


class HomeContent extends StatefulWidget {
  // Fungsi callback untuk mengirim notifikasi ke HomeView shell
  final Function(String message) onNotificationAdded;

  const HomeContent({super.key, required this.onNotificationAdded});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  
  late PageController _pageController;
  final BookController _controller = BookController(); 

  late Timer _timer;
  int _currentPage = 0;

  late TextEditingController _searchController;
  List<BookModel> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
    _startAutoSlider(); 
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _timer.cancel();
    super.dispose();
  }
  
  void _startAutoSlider() {
    final carouselBooks = _controller.books.take(5).toList();
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        if (_currentPage < carouselBooks.length - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }
        _pageController.animateToPage(_currentPage, duration: const Duration(milliseconds: 600), curve: Curves.easeIn);
      }
    });
  }
  
  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      _isSearching = query.isNotEmpty;
      if (_isSearching) {
        _searchResults = _controller.books.where((book) {
          return book.title.toLowerCase().contains(query) || book.author.toLowerCase().contains(query);
        }).toList();
      } else {
        _searchResults = [];
      }
    });
  }
  

  Widget _buildSectionTitle(BuildContext context, String title, {bool showSeeAll = true}) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: darkText)),
            if (showSeeAll)
              TextButton(
                onPressed: () {},
                child: const Text("Lihat Semua", style: TextStyle(color: primaryBlue, fontSize: 14, fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      );
    }
  
  Widget _buildHorizontalBookItem(BookModel book) {
      const double coverWidth = 120;
      const double coverHeight = 180;
      
      return GestureDetector(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetailView(book: book)),
          );

          if (result != null && result is String) {
            widget.onNotificationAdded(result);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(result), duration: const Duration(seconds: 2)),
            );
          }
        },

        child: Container(
          width: coverWidth,
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: coverHeight,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(book.posterPath, width: coverWidth, height: coverHeight, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(width: coverWidth, height: coverHeight, color: secondaryGrey.withOpacity(0.1), child: const Center(child: Icon(Icons.broken_image, color: secondaryGrey, size: 40)))),
                ),
              ),
              const SizedBox(height: 8),
              Text(book.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkText)),
              const SizedBox(height: 2),
              Text(book.author, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, color: secondaryGrey)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star_rounded, size: 16, color: ratingColor),
                  const SizedBox(width: 4),
                  Text("${book.rating}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: darkText)),
                ],
              ),
            ],
          ),
        ),
      );
    }

  Widget _buildGridBookItem(BookModel book) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetailView(book: book)),
        );

        if (result != null && result is String) {
          widget.onNotificationAdded(result);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result), duration: const Duration(seconds: 2)),
          );
        }
      },

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 3))]),
              child: ClipRRect(borderRadius: BorderRadius.circular(10), child: Image.asset(book.posterPath, width: double.infinity, height: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: secondaryGrey.withOpacity(0.15), child: const Center(child: Icon(Icons.broken_image, color: secondaryGrey))))),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(book.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: darkText)),
                Text(book.author, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 10, color: secondaryGrey)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: ratingColor),
                    const SizedBox(width: 4),
                    Text("${book.rating}", style: const TextStyle(fontSize: 11, color: darkText))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final List<BookModel> allBooks = _controller.books;
    final List<BookModel> carouselBooks = allBooks.take(5).toList();
    final List<BookModel> recentlyAccessed = allBooks.skip(5).take(4).toList();
    final List<BookModel> recommended = allBooks.where((b) => b.rating >= 4.5).take(4).toList();
    final List<BookModel> popular = allBooks.where((b) => b.available > 0).take(6).toList();

    return Column(
      children: [
        const SizedBox(height: 8),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: cardColor,
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4)),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Cari buku, penulis, atau kategori...",
                prefixIcon: const Icon(Icons.search, color: secondaryGrey),
                suffixIcon: _isSearching
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: secondaryGrey),
                        onPressed: () => _searchController.clear(),
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // TAMPILAN KONDISIONAL
        Expanded(
          child: _isSearching
              ? _buildSearchResults()
              : _buildHomePage(carouselBooks, recentlyAccessed, recommended, popular),
        ),
      ],
    );
  }

  // ... (Sisa fungsi _buildSearchResults, _buildHomePage, _buildSearchResultItem harus didefinisikan di sini)

  Widget _buildSearchResults() {
    // Implementasi Search Results
    if (_searchResults.isEmpty) {
      return Center(
        child: Text(
          "Tidak ada hasil untuk '${_searchController.text}'",
          style: const TextStyle(fontSize: 16, color: secondaryGrey),
        ),
      );
    }

    return ListView.builder(
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final book = _searchResults[index];
        return _buildSearchResultItem(book);
      },
    );
  }

  Widget _buildSearchResultItem(BookModel book) {
    // Implementasi Search Result Item
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 60, height: 90, decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 5, offset: const Offset(0, 2))]), child: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.asset(book.posterPath, width: 60, height: 90, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: secondaryGrey.withOpacity(0.1), child: const Center(child: Icon(Icons.book, color: secondaryGrey, size: 20)))))),
          const SizedBox(width: 16),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(book.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText), maxLines: 2, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Text("Penulis: ${book.author}", style: const TextStyle(fontSize: 14, color: secondaryGrey), maxLines: 1, overflow: TextOverflow.ellipsis), const SizedBox(height: 4), Row(children: [const Icon(Icons.star, size: 16, color: ratingColor), const SizedBox(width: 4), Text("${book.rating}", style: const TextStyle(fontSize: 14, color: darkText))])])),
        ],
      ),
    );
  }


  Widget _buildHomePage(
    List<BookModel> carouselBooks,
    List<BookModel> recentlyAccessed,
    List<BookModel> recommended,
    List<BookModel> popular,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🎞️ CAROUSEL SLIDER
          _buildSectionTitle(context, "Pilihan Editor", showSeeAll: false),
          SizedBox(
            height: 220,
            child: PageView.builder(
              controller: _pageController,
              itemCount: carouselBooks.length,
              onPageChanged: (index) => _currentPage = index, 
              itemBuilder: (context, index) {
                final book = carouselBooks[index];
                return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => BookDetailView(book: book)));
                      if (result != null && result is String) {
                        widget.onNotificationAdded(result);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result), duration: const Duration(seconds: 2)));
                      }
                    },
                    child: Container(margin: const EdgeInsets.symmetric(horizontal: 8), decoration: BoxDecoration(color: primaryBlue.withOpacity(0.9), borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: primaryBlue.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 5))]), child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Stack(children: [Image.asset(book.posterPath, width: double.infinity, height: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: primaryBlue, child: Center(child: Text(book.title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600))))), Positioned.fill(child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black.withOpacity(0.6), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.center)))), Positioned(bottom: 12, left: 16, right: 16, child: Text(book.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis))]))));
              },
            ),
          ),
          const SizedBox(height: 24),

          // 📖 TERAKHIR DIAKSES
          _buildSectionTitle(context, "Terakhir Diakses"),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentlyAccessed.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                final book = recentlyAccessed[index];
                return _buildHorizontalBookItem(book);
              },
            ),
          ),
          const SizedBox(height: 24),

          // 💡 REKOMENDASI
          _buildSectionTitle(context, "Rekomendasi Terbaik"),
          SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommended.length,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                final book = recommended[index];
                return _buildHorizontalBookItem(book);
              },
            ),
          ),
          const SizedBox(height: 24),

          // 🌟 POPULER
          _buildSectionTitle(context, "Populer Minggu Ini", showSeeAll: true),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 16,
                childAspectRatio: 0.55,
              ),
              itemCount: popular.length,
              itemBuilder: (context, index) {
                final book = popular[index];
                return _buildGridBookItem(book);
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import '../models/book_model.dart'; 
const Color primaryBlue = Color(0xFF007AFF);
const Color lightBackground = Color(0xFFF0F2F5);
const Color cardColor = Colors.white;
const Color darkText = Color(0xFF1E1E1E);
const Color secondaryGrey = Color(0xFF8E8E93);

class BookDetailView extends StatelessWidget {
  final BookModel book;

  const BookDetailView({super.key, required this.book});

  Widget _buildInfoCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 24, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: darkText),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(fontSize: 10, color: secondaryGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    bool isAvailable = book.status == "Available";
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: cardColor,
        border: Border(top: BorderSide(color: secondaryGrey.withOpacity(0.2), width: 0.5)),
      ),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(isAvailable ? "Memulai proses peminjaman ${book.title}" : "Buku sedang dipinjam")),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isAvailable ? primaryBlue : secondaryGrey,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 5,
        ),
        child: Text(
          isAvailable ? "Pinjam Sekarang" : "Antri Pinjaman",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        backgroundColor: lightBackground,
        elevation: 0,
        title: Text(
          "Detail Buku",
          style: TextStyle(color: darkText, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: darkText),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          width: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              book.posterPath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                color: secondaryGrey.withOpacity(0.1),
                                child: const Center(child: Icon(Icons.book_outlined, size: 80, color: secondaryGrey)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            book.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: darkText),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Oleh ${book.author}",
                          style: const TextStyle(fontSize: 16, color: secondaryGrey, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoCard("Rating", "${book.rating}", Icons.star_rounded, Colors.amber),
                        _buildInfoCard("Tersedia", "${book.available}", Icons.inventory_2_outlined, book.available > 0 ? Colors.green.shade700 : Colors.red.shade700),
                        _buildInfoCard("Penerbit", book.publisher, Icons.domain_outlined, primaryBlue),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Deskripsi",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: darkText),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          book.overview,
                          style: TextStyle(fontSize: 15, height: 1.5, color: darkText), 
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildActionButton(context),
        ],
      ),
    );
  }
}
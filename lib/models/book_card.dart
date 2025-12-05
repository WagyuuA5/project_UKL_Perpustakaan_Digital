// lib/widgets/book_card.dart
import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../theme/app_theme.dart';

class BookCard extends StatelessWidget {
  final BookModel book;
  final VoidCallback? onTap;

  const BookCard({super.key, required this.book, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
              child: SizedBox(
                width: 90,
                height: 120,
                child: Image.asset(book.posterPath, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.book)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(book.author, style: const TextStyle(fontSize: 13, color: Colors.black54)),
                    const SizedBox(height: 8),
                    Text(book.overview, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: AppTheme.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(6)), child: Text("Tersedia: ${book.available}", style: TextStyle(color: AppTheme.primary, fontSize: 12))),
                        const Spacer(),
                        Icon(Icons.star, color: AppTheme.gold, size: 18),
                        const SizedBox(width: 4),
                        Text(book.rating.toString(), style: const TextStyle(fontSize: 12)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

const Color primaryBlue = Color(0xFF007AFF);
const Color lightBackground = Color(0xFFF0F2F5);
const Color darkText = Color(0xFF1E1E1E);
const Color secondaryGrey = Color(0xFF8E8E93);
const Color cardColor = Colors.white;

const Color inStockGreen = Color(0xFF34C759);
const Color borrowedRed = Color(0xFFFF3B30);

class Book {
  final String title;
  final String author;
  final double rating;
  final String posterpath;
  final String status;

  Book({
    required this.title,
    required this.author,
    required this.rating,
    required this.posterpath,
    required this.status,
  });

  Book copyWith({
    String? title,
    String? author,
    double? rating,
    String? posterpath, // ✅ Sudah benar: gunakan posterpath
    String? status,
  }) {
    return Book(
      title: title ?? this.title,
      author: author ?? this.author,
      rating: rating ?? this.rating,
      posterpath: posterpath ?? this.posterpath, 
      status: status ?? this.status,
    );
  }
}

final List<Book> initialDummyBooks = [
  Book(
    title: 'tentang kamu',
    author: 'Tere Liye',
    rating: 4.0,
    posterpath: 'assets/images/Tentang_kamu.jpg', 

    status: 'In Stock',
  ),
  Book(
    title: 'janji',
    author: 'Tere Liye',
    rating: 5.0,
    posterpath: 'assets/images/janji_foto.jpg',
    status: 'In Stock',
  ),
  Book(
    title: 'Hujan',
    author: 'Tere Liye',
    rating: 4.5,
    posterpath: 'assets/images/Hujan.jpg',
    status: 'Borrowed',
  ),
  Book(
    title: 'Cantik Itu Luka',
    author: 'Eka Kurniawan',
    rating: 4.5,
    posterpath: 'assets/images/Cantik_itu.jpg',
    status: 'In Stock',
  ),
  Book(
    title: 'Dompet Ayah Sepatu Ibu',
    author: 'J.S. Khairan',
    rating: 4.0,
    posterpath: 'assets/images/dDompet_Ayah.jpg',
    status: 'In Stock',
  ),
];

class LinimasaView extends StatefulWidget {
  const LinimasaView({super.key});

  @override
  State<LinimasaView> createState() => _LinimasaViewState();
}

class _LinimasaViewState extends State<LinimasaView> {
  List<Book> _books = initialDummyBooks;

  void _addBook(Book newBook) {
    setState(() {
      _books.insert(0, newBook);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buku "${newBook.title}" berhasil ditambahkan!')),
    );
  }

  void _editBook(int index, Book updatedBook) {
    setState(() {
      _books[index] = updatedBook;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Buku "${updatedBook.title}" berhasil diperbarui!')),
    );
  }

  // ✅ TAMBAHKAN DIALOG KONFIRMASI SEBELUM HAPUS
  void _deleteBook(int index) {
    final bookTitle = _books[index].title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Buku?'),
          content: Text('Apakah Anda yakin ingin menghapus buku "$bookTitle"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Batal
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                setState(() {
                  _books.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Buku "$bookTitle" berhasil dihapus!')),
                );
              },
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showAddBookModal() {
    showModalBottomSheet<Book?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddBookModal(
            onSave: (book) {
              if (book != null) {
                _addBook(book);
              }
            },
          ),
        );
      },
    );
  }

  void _showOptionsModal(Book book, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BookOptionsModal(
          book: book,
          onEdit: () {
            Navigator.pop(context);
            _showEditBookModal(book, index);
          },
          onDelete: () {
            Navigator.pop(context);
            _deleteBook(index); // ✅ Sekarang memicu dialog konfirmasi
          },
        );
      },
    );
  }

  void _showEditBookModal(Book book, int index) {
    showModalBottomSheet<Book?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddBookModal(
            currentBook: book,
            isEditing: true,
            onSave: (updatedBook) {
              if (updatedBook != null) {
                _editBook(index, updatedBook);
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      appBar: AppBar(
        title: const Text(
          "Linimasa Buku",
          style: TextStyle(fontWeight: FontWeight.bold, color: darkText),
        ),
        backgroundColor: cardColor,
        foregroundColor: darkText,
        elevation: 1,
      ),
      body: _books.isEmpty
          ? const Center(child: Text('Belum ada buku di linimasa Anda.', style: TextStyle(color: secondaryGrey)))
          : ListView.separated(
              padding: const EdgeInsets.only(top: 12, bottom: 80, left: 16, right: 16),
              itemCount: _books.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final book = _books[index];
                return BookCard(
                  book: book,
                  onOptionsPressed: () => _showOptionsModal(book, index),
                  onTap: () {
                    print('Navigasi ke Detail: ${book.title}');
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookModal,
        backgroundColor: primaryBlue,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book book;
  final VoidCallback onOptionsPressed;
  final VoidCallback onTap;

  const BookCard({
    required this.book,
    required this.onOptionsPressed,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildBookCover(book.posterpath), // ✅ Pakai posterpath
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 14,
                          color: secondaryGrey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          BookRating(rating: book.rating),
                          const SizedBox(width: 10),
                          Text('|', style: TextStyle(color: secondaryGrey)),
                          const SizedBox(width: 10),
                          _buildStatusChip(book.status),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: secondaryGrey),
                  onPressed: onOptionsPressed,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ GANTI Image.network → Image.asset
  Widget _buildBookCover(String posterpath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        posterpath,
        width: 60,
        height: 85,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 60,
            height: 85,
            color: Colors.grey.shade300,
            child: Icon(Icons.broken_image, color: secondaryGrey),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    final bool isInStock = status == 'In Stock';
    final Color chipColor = isInStock ? inStockGreen.withOpacity(0.15) : borrowedRed.withOpacity(0.15);
    final Color textColor = isInStock ? inStockGreen : borrowedRed;
    final String label = isInStock ? 'In Stock' : 'Borrowed';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}

// --------------------------------------------------------------------------
// 🌟 KOMPONEN PREMIUM: Rating Bintang
// --------------------------------------------------------------------------

class BookRating extends StatelessWidget {
  final double rating;

  const BookRating({required this.rating, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            color: darkText,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        ...List.generate(5, (index) {
          return Icon(
            index < rating.floor()
                ? Icons.star
                : index < rating
                    ? Icons.star_half
                    : Icons.star_border,
            color: Colors.amber.shade600,
            size: 16,
          );
        }),
      ],
    );
  }
}

// --------------------------------------------------------------------------
// 🌟 KOMPONEN BARU: BookOptionsModal
// --------------------------------------------------------------------------

class BookOptionsModal extends StatelessWidget {
  final Book book;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BookOptionsModal({
    required this.book,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: secondaryGrey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.edit_outlined, color: primaryBlue),
            title: Text('Edit "${book.title}"', style: const TextStyle(color: darkText)),
            onTap: onEdit,
          ),
          Divider(height: 1, color: secondaryGrey.withOpacity(0.2)),
          ListTile(
            leading: Icon(Icons.delete_outline, color: borrowedRed),
            title: Text('Hapus Buku', style: TextStyle(color: borrowedRed)),
            onTap: onDelete,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// --------------------------------------------------------------------------
// 🌟 KOMPONEN PREMIUM: Modal Tambah/Edit Buku
// --------------------------------------------------------------------------

class AddBookModal extends StatefulWidget {
  final Function(Book?) onSave;
  final Book? currentBook;
  final bool isEditing;

  const AddBookModal({
    required this.onSave,
    this.currentBook,
    this.isEditing = false,
    super.key,
  });

  @override
  State<AddBookModal> createState() => _AddBookModalState();
}

class _AddBookModalState extends State<AddBookModal> {
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageController;

  double _currentRating = 4.0;
  String _bookStatus = 'In Stock';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.currentBook?.title ?? '');
    _authorController = TextEditingController(text: widget.currentBook?.author ?? '');
    _descriptionController = TextEditingController(text: 'Deskripsi singkat buku ${widget.currentBook?.title ?? ''}');
    _imageController = TextEditingController(text: widget.currentBook?.posterpath ?? '');

    _currentRating = widget.currentBook?.rating ?? 4.0;
    _bookStatus = widget.currentBook?.status ?? 'In Stock';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_titleController.text.isEmpty || _authorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul dan Penulis harus diisi!')),
      );
      return;
    }

    final newBook = Book(
      title: _titleController.text,
      author: _authorController.text,
      rating: _currentRating,
      posterpath: _imageController.text.isNotEmpty
          ? _imageController.text
          : 'assets/images/tentang_kamu.jpg', // ✅ Placeholder asset lokal
      status: _bookStatus,
    );

    widget.onSave(newBook);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: secondaryGrey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.isEditing ? 'Edit Buku' : 'Tambah Buku Baru 🚀',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkText),
            ),
            const SizedBox(height: 20),

            _buildTextField('Judul Buku', Icons.auto_stories, controller: _titleController),
            const SizedBox(height: 16),
            _buildTextField('Penulis', Icons.person_outline, controller: _authorController),
            const SizedBox(height: 16),
            _buildTextField('Deskripsi Buku (Opsional)', Icons.description_outlined, maxLines: 3, controller: _descriptionController),
            const SizedBox(height: 16),
            _buildTextField('Path Gambar Cover (contoh: assets/images/nama.jpg)', Icons.image, controller: _imageController), // ✅ Ubah hint
            const SizedBox(height: 20),

            const Text('Rating:', style: TextStyle(fontWeight: FontWeight.w600, color: darkText)),
            Center(child: _buildStarRatingSelector()),
            const SizedBox(height: 16),

            const Text('Status Buku:', style: TextStyle(fontWeight: FontWeight.w600, color: darkText)),
            _buildStatusDropdown(),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: Text(
                  widget.isEditing ? 'Simpan Perubahan' : 'Simpan',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, {int maxLines = 1, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: primaryBlue.withOpacity(0.7)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
      ),
    );
  }

  Widget _buildStarRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _currentRating ? Icons.star_rounded : Icons.star_border_rounded,
            color: Colors.amber.shade600,
            size: 36,
          ),
          onPressed: () {
            setState(() {
              _currentRating = index + 1.0;
            });
          },
        );
      }),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButtonFormField<String>(
      value: _bookStatus,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.check_circle_outline, color: primaryBlue),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: <String>['In Stock', 'Borrowed']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _bookStatus = newValue!;
        });
      },
    );
  }
}
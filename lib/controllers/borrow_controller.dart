// // lib/controllers/borrow_controller.dart
// import '../models/book_model.dart';

// class BorrowController {
//   static final BorrowController _instance = BorrowController._internal();
//   factory BorrowController() => _instance;
//   BorrowController._internal();

//   final List<BookModel> _borrowedBooks = [];

//   List<BookModel> get borrowedBooks => List.unmodifiable(_borrowedBooks);

//   bool isBorrowed(int bookId) {
//     return _borrowedBooks.any((book) => book.id == bookId);
//   }

//   void borrowBook(BookModel book) {
//     if (!_borrowedBooks.any((b) => b.id == book.id)) {
//       final borrowedBook = BookModel(
//         id: book.id,
//         title: book.title,
//         author: book.author,
//         overview: book.overview,
//         publisher: book.publisher,
//         status: "Borrowed",
//         rating: book.rating,
//         posterPath: book.posterPath,
//         available: 0,
//         reviews: book.reviews,
//       );
//       _borrowedBooks.add(borrowedBook);
//     }
//   }

//   void returnBook(int bookId) {
//     _borrowedBooks.removeWhere((book) => book.id == bookId);
//   }
// }

class BookModel {
  final int id;
  String title;
  String author;
  String overview;
  String publisher;
  String status;
  double rating;
  String posterPath;
  int available;

  BookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.overview,
    required this.publisher,
    required this.status,
    required this.rating,
    required this.posterPath,
    this.available = 1,
  });
}
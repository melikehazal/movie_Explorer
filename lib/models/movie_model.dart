//API'den gelen her film verisini Movie nesnesine dönüştürüyor.
//bu modeli apı_service.dart'ta kullanacağız.

class Movie {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final double rating;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.rating,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'No Title',
      overview: json['overview'] ?? 'No Overview Available',
      posterPath: json['poster_path'] ?? json['posterPath'] ?? '',
      rating: (json['vote_average'] ?? json['rating'] ?? 0).toDouble(),
    );
  }
}

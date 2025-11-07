import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Box _favoritesBox = Hive.box('favoritesBox');

  List<Movie> get favorites {
    final rawList = _favoritesBox.values.toList();
    return rawList
        .map((e) => Movie.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  void addFavorite(Movie movie) {
    if (!isFavorite(movie)) {
      _favoritesBox.put(movie.id, {
        'id': movie.id,
        'title': movie.title,
        'posterPath': movie.posterPath != null
            ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
            : null,
        'overview': movie.overview,
        'rating': movie.rating,
      });
      notifyListeners();
    }
  }

  void removeFavorite(Movie movie) {
    _favoritesBox.delete(movie.id);
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favoritesBox.containsKey(movie.id);
  }

  void clearFavorites() {
    _favoritesBox.clear();
    notifyListeners();
  }
}

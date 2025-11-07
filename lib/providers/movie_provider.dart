import 'package:flutter/material.dart';
import 'package:movie_explorer/models/movie_model.dart';
import 'package:movie_explorer/services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();

  List<Movie> _movies = [];
  List<Movie> get movies =>
      _movies; // Dışarıya sadece okunabilir şekilde açıyoruz.

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
    _isLoading = true; //yükleniyor göster
    notifyListeners(); //dinleyicilere haber ver(dönen çark gibi şey)

    try {
      final data = await apiService.fetchPopularMovies();
      _movies = data;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to load movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      return fetchPopularMovies();
    }

    _isLoading = true;
    notifyListeners();

    try {
      final data = await apiService.searchMovies(query);
      _movies = data;
      _errorMessage = '';
    } catch (e) {
      _errorMessage = 'Failed to search movies: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'package:movie_explorer/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _apiKey = '6893fc209aba7f6c0cba7467a4117c01';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchPopularMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  Future<List<Movie>> fetchTrendingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/trending/movie/week?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  Future<List<Movie>> fetchUpcomingMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/upcoming?api_key=$_apiKey'),
    );
    return _handleResponse(response);
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search/movie?api_key=$_apiKey&query=$query'),
    );
    return _handleResponse(response);
  }

  Future<List<Movie>> fetchDiscoverMovies() async {
    final randomPage =
        (1 + (DateTime.now().millisecond % 10)); // 1-10 arası rastgele sayfa
    final response = await http.get(
      Uri.parse(
        '$_baseUrl/discover/movie?api_key=$_apiKey&page=$randomPage&sort_by=popularity.desc',
      ),
    );
    print('Discover response: ${response.statusCode}');
    return _handleResponse(response);
  }

  //  Ortak response parser
  List<Movie> _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List results = data['results'];
      return results.map((json) => Movie.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}

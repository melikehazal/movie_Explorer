import 'package:flutter/material.dart';
import 'package:movie_explorer/models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.posterPath != null
        ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
        : null;

    return Scaffold(
      appBar: AppBar(title: Text(movie.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // poster: ternary kullanarak else yerine iki durum veriyoruz
            imageUrl != null
                ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        imageUrl,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.movie, size: 100, color: Colors.grey),
                  ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20.0),
                const SizedBox(width: 4.0),
                Text(
                  movie.rating.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              movie.overview.isNotEmpty
                  ? movie.overview
                  : 'No Overview Available',
              style: const TextStyle(fontSize: 16.0, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

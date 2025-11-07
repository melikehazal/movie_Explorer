import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_explorer/screens/detail_screen.dart';
import '../models/movie_model.dart';
import '../providers/favorites_provider.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.posterPath != null && movie.posterPath!.isNotEmpty
        ? (movie.posterPath!.startsWith('http')
              ? movie.posterPath! // Hive'dan geliyorsa tam URL
              : 'https://image.tmdb.org/t/p/w500${movie.posterPath!.startsWith('/') ? movie.posterPath : '/${movie.posterPath}'}') // API'den geliyorsa
        : null;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: movie)),
        );
      },
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 🎬 Poster + içerik
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: imageUrl != null
                        ? Image.network(
                            imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            // Yüklenirken progress indicator
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: Colors.grey[850],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              );
                            },
                            //  Hatalı görselde fallback ikon
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Colors.grey[850],
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      size: 50,
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                          )
                        : Container(
                            color: Colors.grey[850],
                            child: const Center(
                              child: Icon(
                                Icons.movie,
                                size: 50,
                                color: Colors.white54,
                              ),
                            ),
                          ),
                  ),
                ),

                //  Başlık + Puan
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //  Favori butonu (sağ üst köşede)
            Positioned(
              top: 6,
              right: 6,
              child: Consumer<FavoritesProvider>(
                builder: (context, favProvider, _) {
                  final isFav = favProvider.isFavorite(movie);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.redAccent : Colors.white,
                    ),
                    onPressed: () {
                      isFav
                          ? favProvider.removeFavorite(movie)
                          : favProvider.addFavorite(movie);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

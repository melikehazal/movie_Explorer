import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_explorer/models/movie_model.dart';
import 'package:movie_explorer/providers/favorites_provider.dart';
import 'package:movie_explorer/widgtes/movie_card.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favoriteMovies = favoritesProvider.favorites;
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite Movies'),
        centerTitle: true,
      ),
      body: favoriteMovies.isEmpty
          ? const Center(
              child: Text(
                'No favorite movies added yet.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: favoriteMovies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final movie = favoriteMovies[index];
                return MovieCard(movie: movie);
              },
            ),
    );
  }
}

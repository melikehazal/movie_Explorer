import 'package:flutter/widgets.dart';
import 'package:movie_explorer/providers/movie_provider.dart';
import 'package:movie_explorer/widgtes/movie_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MovieListTab extends StatefulWidget {
  final String type; //popular,trending,upcoming
  const MovieListTab({super.key, required this.type});

  @override
  State<MovieListTab> createState() => _MovieListTabState();
}

class _MovieListTabState extends State<MovieListTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MovieProvider>(context, listen: false);
      if (widget.type == 'popular') {
        provider.fetchPopularMovies();
      } else if (widget.type == 'trending') {
        provider.fetchTrendingMovies();
      } else if (widget.type == 'discover') {
        provider.fetchDiscoverMovies();
      } else {
        provider.fetchUpcomingMovies();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.errorMessage.isNotEmpty) {
      return Center(child: Text(provider.errorMessage));
    }

    final movies = provider.movies;
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie: movie);
      },
    );
  }
}

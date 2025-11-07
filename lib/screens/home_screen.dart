import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_explorer/screens/favorites_screen.dart';

import 'package:movie_explorer/widgtes/movie_list_tab.dart';
import 'package:movie_explorer/widgtes/search_bar.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final provider = Provider.of<MovieProvider>(context, listen: false);
      provider.searchMovies(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Popular / Trending / Upcoming /Discover
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Movie Explorer'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                );
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Column(
              children: [
                SearchBarWidget(onChanged: _onSearchChanged),
                const TabBar(
                  tabs: [
                    Tab(text: 'Popular'),
                    Tab(text: 'Trending'),
                    Tab(text: 'Upcoming'),
                    Tab(text: 'Discover'),
                  ],
                  indicatorColor: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            MovieListTab(type: 'popular'),
            MovieListTab(type: 'trending'),
            MovieListTab(type: 'upcoming'),
            MovieListTab(type: 'discover'),
          ],
        ),
      ),
    );
  }
}

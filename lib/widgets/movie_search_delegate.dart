import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../routes.dart';
import 'movie_poster.dart';

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  final List<Movie> movies;
  final List<String> recentSearches;

  MovieSearchDelegate({
    required this.movies,
    this.recentSearches = const [],
  }) : super(
          searchFieldLabel: 'Поиск фильмов...',
          searchFieldStyle: const TextStyle(fontSize: 16),
        );

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.colorScheme.surface,
        iconTheme: IconThemeData(color: theme.colorScheme.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: theme.colorScheme.onSurface.withAlpha(128)),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _searchMovies(query);

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Ничего не найдено по запросу "$query"',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Попробуйте изменить запрос',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      );
    }

    return _buildMovieList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      // Показываем жанры для быстрого выбора
      final genres = movies.map((m) => m.genre).toSet().toList()..sort();

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Поиск по жанрам',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: genres.map((genre) {
                return ActionChip(
                  avatar: Icon(_getGenreIcon(genre), size: 18),
                  label: Text(genre),
                  onPressed: () {
                    query = genre;
                    showResults(context);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Популярные фильмы',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            ...movies
                .where((m) => m.rating >= 8.5)
                .take(5)
                .map((movie) => _buildMovieTile(context, movie)),
          ],
        ),
      );
    }

    final suggestions = _searchMovies(query);
    return _buildMovieList(context, suggestions);
  }

  List<Movie> _searchMovies(String query) {
    final lowerQuery = query.toLowerCase();
    return movies.where((movie) {
      return movie.title.toLowerCase().contains(lowerQuery) ||
          movie.genre.toLowerCase().contains(lowerQuery) ||
          movie.year.toString().contains(lowerQuery) ||
          movie.description.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  Widget _buildMovieList(BuildContext context, List<Movie> movies) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: movies.length,
      itemBuilder: (context, index) => _buildMovieTile(context, movies[index]),
    );
  }

  Widget _buildMovieTile(BuildContext context, Movie movie) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: SizedBox(
          width: 50,
          height: 75,
          child: MoviePoster(
            movie: movie,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        title: Text(
          movie.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${movie.year} • ${movie.genre}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  movie.rating.toStringAsFixed(1),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          close(context, movie);
          Navigator.of(context).pushNamed(
            AppRoutes.detail,
            arguments: movie.id,
          );
        },
      ),
    );
  }

  IconData _getGenreIcon(String genre) {
    switch (genre.toLowerCase()) {
      case 'фантастика':
        return Icons.rocket_launch;
      case 'боевик':
        return Icons.local_fire_department;
      case 'драма':
        return Icons.theater_comedy;
      case 'комедия':
        return Icons.sentiment_very_satisfied;
      case 'триллер':
        return Icons.psychology;
      case 'ужасы':
        return Icons.sentiment_very_dissatisfied;
      case 'анимация':
        return Icons.animation;
      case 'приключения':
        return Icons.explore;
      case 'детектив':
        return Icons.search;
      default:
        return Icons.movie;
    }
  }
}

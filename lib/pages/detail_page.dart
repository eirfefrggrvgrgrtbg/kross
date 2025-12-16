import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorites/favorites_cubit.dart';
import '../cubit/watch_later/watch_later_cubit.dart';
import '../data/movies_repository.dart';
import '../di/injection.dart';
import '../models/movie.dart';

class DetailPage extends StatefulWidget {
  final int movieId;

  const DetailPage({super.key, required this.movieId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Movie? _movie;
  bool _isLoading = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _loadMovie();
  }

  Future<void> _loadMovie() async {
    final repository = getIt<MoviesRepository>();
    final movie = await repository.getMovieById(widget.movieId);
    setState(() {
      _movie = movie;
      _isLoading = false;
    });
  }

  Widget _buildPosterBackground(Movie movie) {
    if (movie.posterUrl != null && movie.posterUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: movie.posterUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => _buildPlaceholder(),
      );
    } else if (movie.poster != null) {
      return Image.memory(
        movie.poster!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    } else if (movie.posterAssetPath != null) {
      return Image.asset(
        movie.posterAssetPath!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.movie, size: 64, color: Colors.grey),
      ),
    );
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    if (_isPlaying) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.play_circle, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Воспроизведение: ${_movie?.title}'),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Стоп',
            onPressed: () {
              setState(() {
                _isPlaying = false;
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_movie == null) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
              const SizedBox(height: 16),
              const Text('Фильм не найден'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      );
    }

    final movie = _movie!;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavoritesCubit>()),
        BlocProvider.value(value: getIt<WatchLaterCubit>()),
      ],
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 350,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  movie.title,
                  style: const TextStyle(
                    shadows: [
                      Shadow(blurRadius: 10, color: Colors.black),
                      Shadow(blurRadius: 20, color: Colors.black),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildPosterBackground(movie),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(179),
                          ],
                        ),
                      ),
                    ),
                    // Кнопка воспроизведения по центру
                    Center(
                      child: Material(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(40),
                        child: InkWell(
                          onTap: _togglePlay,
                          borderRadius: BorderRadius.circular(40),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 48,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    final isFavorite = state.favoriteIds.contains(movie.id);
                    return IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () {
                        context.read<FavoritesCubit>().toggleFavorite(movie.id);
                      },
                    );
                  },
                ),
                BlocBuilder<WatchLaterCubit, WatchLaterState>(
                  builder: (context, state) {
                    final isInWatchLater = state.watchLaterIds.contains(movie.id);
                    return IconButton(
                      icon: Icon(
                        isInWatchLater ? Icons.bookmark : Icons.bookmark_border,
                        color: isInWatchLater ? Colors.amber : Colors.white,
                      ),
                      onPressed: () {
                        context.read<WatchLaterCubit>().toggleWatchLater(movie.id);
                      },
                    );
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Теги с информацией
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildInfoChip(
                          context,
                          icon: Icons.category,
                          label: movie.genre,
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        _buildInfoChip(
                          context,
                          icon: Icons.calendar_today,
                          label: '${movie.year}',
                        ),
                        _buildInfoChip(
                          context,
                          icon: Icons.access_time,
                          label: '${movie.durationMinutes} мин',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Рейтинг
                    _buildRatingSection(context, movie),
                    const SizedBox(height: 24),

                    // Кнопки действий
                    _buildActionButtons(context, movie),
                    const SizedBox(height: 24),

                    // Описание
                    Text(
                      'Описание',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      movie.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                    ),
                    const SizedBox(height: 32),

                    // Дополнительная информация
                    _buildAdditionalInfo(context, movie),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildRatingSection(BuildContext context, Movie movie) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.star, color: Colors.black, size: 28),
                const SizedBox(height: 4),
                Text(
                  movie.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Рейтинг',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getRatingDescription(movie.rating),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: movie.rating / 10,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getRatingColor(movie.rating),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getRatingDescription(double rating) {
    if (rating >= 9.0) return 'Шедевр';
    if (rating >= 8.0) return 'Отличный фильм';
    if (rating >= 7.0) return 'Хороший фильм';
    if (rating >= 6.0) return 'Неплохой фильм';
    return 'Средний фильм';
  }

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) return Colors.green;
    if (rating >= 6.0) return Colors.orange;
    return Colors.red;
  }

  Widget _buildActionButtons(BuildContext context, Movie movie) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: FilledButton.icon(
            onPressed: _togglePlay,
            icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            label: Text(_isPlaying ? 'Пауза' : 'Смотреть'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFavorite = state.favoriteIds.contains(movie.id);
            return Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(movie.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFavorite
                            ? 'Удалено из избранного'
                            : 'Добавлено в избранное',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                ),
                label: const Text(''),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 8),
        BlocBuilder<WatchLaterCubit, WatchLaterState>(
          builder: (context, state) {
            final isInWatchLater = state.watchLaterIds.contains(movie.id);
            return Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<WatchLaterCubit>().toggleWatchLater(movie.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isInWatchLater
                            ? 'Удалено из закладок'
                            : 'Добавлено в "Посмотреть позже"',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                icon: Icon(
                  isInWatchLater ? Icons.bookmark : Icons.bookmark_border,
                  color: isInWatchLater ? Colors.amber : null,
                ),
                label: const Text(''),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAdditionalInfo(BuildContext context, Movie movie) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Информация о фильме',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _buildInfoRow('Год выпуска', '${movie.year}'),
        _buildInfoRow('Жанр', movie.genre),
        _buildInfoRow('Продолжительность', '${movie.durationMinutes} минут'),
        _buildInfoRow('Рейтинг', '${movie.rating}/10'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

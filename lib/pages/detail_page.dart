import 'package:flutter/material.dart';

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
        body: const Center(
          child: Text('Фильм не найден'),
        ),
      );
    }

    final movie = _movie!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                movie.title,
                style: const TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              background: movie.poster != null
                  ? Image.memory(
                      movie.poster!,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Icon(
                          Icons.movie,
                          size: 64,
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Информация о фильме
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          movie.genre,
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('${movie.year}'),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('${movie.durationMinutes} мин'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Рейтинг
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 28),
                      const SizedBox(width: 8),
                      Text(
                        movie.rating.toStringAsFixed(1),
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '/ 10',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Описание
                  Text(
                    'Описание',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.6,
                        ),
                  ),
                  const SizedBox(height: 32),

                  // Кнопки действий
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Начинаем воспроизведение...'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.play_arrow),
                          label: const Text('Смотреть'),
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton.outlined(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Добавлено в избранное'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.favorite_border),
                      ),
                      const SizedBox(width: 8),
                      IconButton.outlined(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Добавлено в "Посмотреть позже"'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.bookmark_border),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorites/favorites_cubit.dart';
import '../cubit/watch_later/watch_later_cubit.dart';
import '../data/movies_repository.dart';
import '../di/injection.dart';
import '../models/movie.dart';
import '../routes.dart';

class MyCollectionPage extends StatefulWidget {
  const MyCollectionPage({super.key});

  @override
  State<MyCollectionPage> createState() => _MyCollectionPageState();
}

class _MyCollectionPageState extends State<MyCollectionPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Movie> _allMovies = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final movies = await getIt<MoviesRepository>().getAllMovies();
    setState(() {
      _allMovies = movies;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavoritesCubit>()),
        BlocProvider.value(value: getIt<WatchLaterCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Моя коллекция'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.favorite), text: 'Избранное'),
              Tab(icon: Icon(Icons.bookmark), text: 'Смотреть позже'),
            ],
          ),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController,
                children: [
                  // Избранное
                  BlocBuilder<FavoritesCubit, FavoritesState>(
                    builder: (context, state) {
                      final favoriteMovies = _allMovies
                          .where((m) => state.favoriteIds.contains(m.id))
                          .toList();
                      return _buildMovieList(
                        favoriteMovies,
                        'Нет избранных фильмов',
                        'Добавьте фильмы в избранное, нажав на сердечко',
                        Icons.favorite_border,
                      );
                    },
                  ),
                  // Смотреть позже
                  BlocBuilder<WatchLaterCubit, WatchLaterState>(
                    builder: (context, state) {
                      final watchLaterMovies = _allMovies
                          .where((m) => state.watchLaterIds.contains(m.id))
                          .toList();
                      return _buildMovieList(
                        watchLaterMovies,
                        'Список пуст',
                        'Добавьте фильмы для просмотра позже',
                        Icons.bookmark_border,
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMovieList(
    List<Movie> movies,
    String emptyTitle,
    String emptySubtitle,
    IconData emptyIcon,
  ) {
    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(emptyIcon, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              emptyTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              emptySubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[500],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(movie);
      },
    );
  }

  Widget _buildMovieCard(Movie movie) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.detail,
            arguments: movie.id,
          );
        },
        child: Row(
          children: [
            // Постер
            SizedBox(
              width: 100,
              height: 150,
              child: _buildPoster(movie),
            ),
            // Информация
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie.year} • ${movie.genre}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(width: 16),
                        const Icon(Icons.access_time, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.durationMinutes} мин',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Кнопки действий
                    Row(
                      children: [
                        BlocBuilder<FavoritesCubit, FavoritesState>(
                          builder: (context, state) {
                            final isFav = state.favoriteIds.contains(movie.id);
                            return IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: isFav ? Colors.red : Colors.grey,
                              ),
                              onPressed: () {
                                getIt<FavoritesCubit>().toggleFavorite(movie.id);
                              },
                            );
                          },
                        ),
                        BlocBuilder<WatchLaterCubit, WatchLaterState>(
                          builder: (context, state) {
                            final isWL = state.watchLaterIds.contains(movie.id);
                            return IconButton(
                              icon: Icon(
                                isWL ? Icons.bookmark : Icons.bookmark_border,
                                color: isWL ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                                getIt<WatchLaterCubit>().toggleWatchLater(movie.id);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster(Movie movie) {
    final imageUrl = movie.posterUrl ?? movie.posterAssetPath;
    
    if (imageUrl != null && imageUrl.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: const Icon(Icons.movie, size: 40, color: Colors.grey),
        ),
      );
    }

    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.movie, size: 40, color: Colors.grey),
      ),
    );
  }
}

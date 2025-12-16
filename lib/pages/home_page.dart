import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../cubit/favorites/favorites_cubit.dart';
import '../di/injection.dart';
import '../models/movie.dart';
import '../routes.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_mini_poster.dart';
import '../widgets/movie_poster.dart';
import '../widgets/movie_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPosterIndex = 0;
  String _activeFilter = 'all';
  String? _selectedGenre;

  void _nextPoster(int moviesLength) {
    if (moviesLength > 0) {
      setState(() {
        _currentPosterIndex = (_currentPosterIndex + 1) % moviesLength;
      });
    }
  }

  void _applyFilter(String filter) {
    setState(() {
      _activeFilter = filter;
      if (filter != 'genre') {
        _selectedGenre = null;
      }
    });
  }

  void _selectGenre(String genre) {
    setState(() {
      _activeFilter = 'genre';
      _selectedGenre = genre;
    });
  }

  List<Movie> _applyFilters(List<Movie> movies, Set<int> favoriteIds) {
    List<Movie> filtered;
    
    switch (_activeFilter) {
      case 'new':
        filtered = movies.where((m) => m.year >= 2015).toList();
        break;
      case 'top':
        filtered = movies.where((m) => m.rating >= 8.5).toList()
          ..sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'favorites':
        filtered = movies.where((m) => favoriteIds.contains(m.id)).toList();
        break;
      case 'genre':
        if (_selectedGenre != null) {
          filtered = movies.where((m) => m.genre == _selectedGenre).toList();
        } else {
          filtered = movies;
        }
        break;
      default:
        filtered = movies;
    }
    
    return filtered;
  }

  List<String> _getUniqueGenres(List<Movie> movies) {
    return movies.map((m) => m.genre).toSet().toList()..sort();
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

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>()..add(const LoadMovies()),
        ),
        BlocProvider.value(
          value: getIt<FavoritesCubit>(),
        ),
      ],
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final movies = state is HomeLoaded ? state.movies : <Movie>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'CineOnline',
                style: TextStyle(
                  fontFamily: 'CustomFont',
                  fontWeight: FontWeight.bold,
                ),
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: MovieSearchDelegate(movies: movies),
                    );
                  },
                ),
              ],
            ),
            body: _buildBody(context, state, movies, isWideScreen),
          );
        },
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    HomeState state,
    List<Movie> movies,
    bool isWideScreen,
  ) {
    if (state is HomeLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is HomeError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Ошибка: ${state.message}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(const LoadMovies());
              },
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, favState) {
        final favoriteIds = favState.favoriteIds;
        final displayMovies = _applyFilters(movies, favoriteIds);
        final genres = _getUniqueGenres(movies);

        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeBloc>().add(const RefreshMovies());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Приветствие
                  Text(
                    'Добро пожаловать в CineOnline!',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Смотрите лучшие фильмы и сериалы в отличном качестве. '
                    '${movies.length} фильмов в каталоге.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 24),

                  // Главный баннер
                  if (movies.isNotEmpty) _buildMainBanner(context, movies),
                  const SizedBox(height: 24),

                  // Популярное (горизонтальный список)
                  _buildPopularSection(context, movies),
                  const SizedBox(height: 24),

                  // Жанры
                  _buildGenresSection(context, genres),
                  const SizedBox(height: 16),

                  // Фильтры
                  _buildFiltersSection(context, favoriteIds.length),
                  const SizedBox(height: 24),

                  // Список фильмов
                  _buildMoviesSection(
                    context,
                    displayMovies,
                    favoriteIds,
                    isWideScreen,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainBanner(BuildContext context, List<Movie> movies) {
    final currentMovie = movies[_currentPosterIndex % movies.length];

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRoutes.detail,
          arguments: currentMovie.id,
        );
      },
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(51),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            MoviePoster(movie: currentMovie),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withAlpha(230),
                    Colors.black.withAlpha(77),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentMovie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, size: 14, color: Colors.black),
                            const SizedBox(width: 2),
                            Text(
                              currentMovie.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${currentMovie.year} • ${currentMovie.genre}',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Row(
                children: [
                  _buildBannerButton(
                    icon: Icons.play_circle_filled,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.detail,
                        arguments: currentMovie.id,
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  _buildBannerButton(
                    icon: Icons.navigate_next,
                    onTap: () => _nextPoster(movies.length),
                  ),
                ],
              ),
            ),
            // Индикаторы
            Positioned(
              bottom: 8,
              right: 16,
              child: Row(
                children: List.generate(
                  movies.length > 5 ? 5 : movies.length,
                  (index) => Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPosterIndex % (movies.length > 5 ? 5 : movies.length) == index
                          ? Colors.white
                          : Colors.white38,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.black45,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }

  Widget _buildPopularSection(BuildContext context, List<Movie> movies) {
    final popularMovies = movies.toList()
      ..sort((a, b) => b.rating.compareTo(a.rating));
    final topMovies = popularMovies.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Популярное',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                _applyFilter('top');
              },
              child: const Text('Смотреть все'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: topMovies.isEmpty
              ? const Center(child: Text('Нет фильмов'))
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topMovies.length,
                  itemBuilder: (context, index) {
                    return MovieMiniPoster(
                      movie: topMovies[index],
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          AppRoutes.detail,
                          arguments: topMovies[index].id,
                        );
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildGenresSection(BuildContext context, List<String> genres) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Жанры',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              final isSelected = _activeFilter == 'genre' && _selectedGenre == genre;

              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () => _selectGenre(genre),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primaryContainer
                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getGenreIcon(genre),
                          size: 32,
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          genre,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: isSelected ? FontWeight.bold : null,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : null,
                              ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFiltersSection(BuildContext context, int favoritesCount) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilterChip(
          label: const Text('Все'),
          selected: _activeFilter == 'all',
          onSelected: (_) => _applyFilter('all'),
        ),
        FilterChip(
          label: const Text('Новинки (2015+)'),
          selected: _activeFilter == 'new',
          onSelected: (_) => _applyFilter('new'),
          avatar: _activeFilter == 'new' ? null : const Icon(Icons.new_releases, size: 18),
        ),
        FilterChip(
          label: const Text('Топ рейтинга'),
          selected: _activeFilter == 'top',
          onSelected: (_) => _applyFilter('top'),
          avatar: _activeFilter == 'top' ? null : const Icon(Icons.star, size: 18),
        ),
        FilterChip(
          label: Text('Избранное ($favoritesCount)'),
          selected: _activeFilter == 'favorites',
          onSelected: (_) => _applyFilter('favorites'),
          avatar: _activeFilter == 'favorites' 
              ? null 
              : const Icon(Icons.favorite, size: 18),
        ),
      ],
    );
  }

  Widget _buildMoviesSection(
    BuildContext context,
    List<Movie> displayMovies,
    Set<int> favoriteIds,
    bool isWideScreen,
  ) {
    String title = 'Все фильмы';
    if (_activeFilter == 'new') {
      title = 'Новинки';
    } else if (_activeFilter == 'top') {
      title = 'Топ по рейтингу';
    } else if (_activeFilter == 'favorites') {
      title = 'Избранное';
    } else if (_activeFilter == 'genre' && _selectedGenre != null) {
      title = _selectedGenre!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${displayMovies.length}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (displayMovies.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    _activeFilter == 'favorites'
                        ? Icons.favorite_border
                        : Icons.movie_filter,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _activeFilter == 'favorites'
                        ? 'Нет фильмов в избранном'
                        : 'Нет фильмов по выбранному фильтру',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  if (_activeFilter == 'favorites')
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Добавьте фильмы в избранное, нажав на ❤️',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                      ),
                    ),
                ],
              ),
            ),
          )
        else if (isWideScreen)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: displayMovies.length,
            itemBuilder: (context, index) {
              final movie = displayMovies[index];
              return MovieCard(
                movie: movie,
                isFavorite: favoriteIds.contains(movie.id),
                onFavoriteToggle: () => context
                    .read<FavoritesCubit>()
                    .toggleFavorite(movie.id),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.detail,
                    arguments: movie.id,
                  );
                },
              );
            },
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: displayMovies.length,
            itemBuilder: (context, index) {
              final movie = displayMovies[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 280,
                  child: MovieCard(
                    movie: movie,
                    isFavorite: favoriteIds.contains(movie.id),
                    onFavoriteToggle: () => context
                        .read<FavoritesCubit>()
                        .toggleFavorite(movie.id),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        AppRoutes.detail,
                        arguments: movie.id,
                      );
                    },
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}

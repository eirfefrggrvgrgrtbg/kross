import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../di/injection.dart';
import '../models/movie.dart';
import '../routes.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_mini_poster.dart';
import '../widgets/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPosterIndex = 0;
  final List<String> _posterAssets = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
    'assets/images/5.jpg',
  ];

  void _nextPoster() {
    setState(() {
      _currentPosterIndex = (_currentPosterIndex + 1) % _posterAssets.length;
    });
  }

  final List<Map<String, dynamic>> _categories = [
    {
      'title': 'Новинки',
      'icon': Icons.new_releases,
      'description': 'Самые свежие релизы'
    },
    {
      'title': 'Топ-10',
      'icon': Icons.trending_up,
      'description': 'Популярные фильмы недели'
    },
    {
      'title': 'Сериалы',
      'icon': Icons.tv,
      'description': 'Сериалы на любой вкус'
    },
    {
      'title': 'Избранное',
      'icon': Icons.favorite,
      'description': 'Ваши любимые фильмы'
    },
    {
      'title': 'Настройки',
      'icon': Icons.settings,
      'description': 'Настройки приложения'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 600;

    return BlocProvider(
      create: (context) => getIt<HomeBloc>()..add(const LoadMovies()),
      child: Scaffold(
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
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Поиск фильмов')),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
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

            final movies =
                state is HomeLoaded ? state.movies : <Movie>[];

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
                      // Описание сервиса
                      Text(
                        'Добро пожаловать в CineOnline!',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Смотрите тысячи фильмов и сериалов в отличном качестве. '
                        'Новинки кинопроката и классика мирового кино — всё в одном месте.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(height: 24),

                      // Главный постер с циклической сменой
                      GestureDetector(
                        onTap: _nextPoster,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey[300],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              movies.isNotEmpty &&
                                      movies[_currentPosterIndex %
                                              movies.length]
                                          .poster !=
                                          null
                                  ? Image.memory(
                                      movies[_currentPosterIndex %
                                              movies.length]
                                          .poster!,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Icon(
                                        Icons.movie,
                                        size: 64,
                                        color: Colors.grey,
                                      ),
                                    ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                        Colors.black.withAlpha(204),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (movies.isNotEmpty)
                                        Expanded(
                                          child: Text(
                                            movies[_currentPosterIndex %
                                                    movies.length]
                                                .title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      TextButton.icon(
                                        onPressed: _nextPoster,
                                        icon: const Icon(
                                          Icons.navigate_next,
                                          color: Colors.white,
                                        ),
                                        label: const Text(
                                          'Следующий',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Горизонтальный ListView мини-постеров
                      Text(
                        'Популярное',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 160,
                        child: movies.isEmpty
                            ? const Center(child: Text('Нет фильмов'))
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movies.length,
                                itemBuilder: (context, index) {
                                  return MovieMiniPoster(
                                    movie: movies[index],
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        AppRoutes.detail,
                                        arguments: movies[index].id,
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 24),

                      // Категории (карточки)
                      Text(
                        'Категории',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),
                      ..._categories.map(
                        (category) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: CategoryCard(
                            title: category['title'],
                            icon: category['icon'],
                            description: category['description'],
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Выбрана категория: ${category['title']}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Все фильмы (адаптивный layout)
                      Text(
                        'Все фильмы',
                        style:
                            Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      const SizedBox(height: 12),
                      if (movies.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text('Загрузка фильмов...'),
                          ),
                        )
                      else if (isWideScreen)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return MovieCard(
                              movie: movies[index],
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.detail,
                                  arguments: movies[index].id,
                                );
                              },
                            );
                          },
                        )
                      else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: movies.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: SizedBox(
                                height: 280,
                                child: MovieCard(
                                  movie: movies[index],
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.detail,
                                      arguments: movies[index].id,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


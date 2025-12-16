import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorites/favorites_cubit.dart';
import '../cubit/watch_later/watch_later_cubit.dart';
import '../data/user_service.dart';
import '../di/injection.dart';
import '../routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = UserService.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: getIt<FavoritesCubit>()),
        BlocProvider.value(value: getIt<WatchLaterCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Профиль'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Аватар
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 24),
              
              // Имя пользователя
              Text(
                user.fullName ?? 'Пользователь',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                user.email ?? 'email@example.com',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              
              const SizedBox(height: 32),
              
              // Статистика коллекции
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, favState) {
                  return BlocBuilder<WatchLaterCubit, WatchLaterState>(
                    builder: (context, watchState) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Моя коллекция',
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const Divider(),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildStatItem(
                                      context,
                                      Icons.favorite,
                                      Colors.red,
                                      'Избранное',
                                      favState.favoriteIds.length.toString(),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 1,
                                    color: Colors.grey[300],
                                  ),
                                  Expanded(
                                    child: _buildStatItem(
                                      context,
                                      Icons.bookmark,
                                      Colors.blue,
                                      'Смотреть позже',
                                      watchState.watchLaterIds.length.toString(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              
              const SizedBox(height: 16),
              
              // Данные профиля
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('ФИО'),
                      subtitle: Text(user.fullName ?? 'Не указано'),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text('Email'),
                      subtitle: Text(user.email ?? 'Не указано'),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Кнопка выхода
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    UserService.instance.logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Выйти из аккаунта'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    foregroundColor: Colors.red,
                    side: const BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    IconData icon,
    Color color,
    String label,
    String value,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/theme/theme_cubit.dart';
import '../di/injection.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              bloc: getIt<ThemeCubit>(),
              builder: (context, themeMode) {
                return SwitchListTile(
                  secondary: Icon(
                    themeMode == ThemeMode.dark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                  ),
                  title: const Text('Тёмная тема'),
                  subtitle: Text(
                    themeMode == ThemeMode.dark ? 'Включена' : 'Выключена',
                  ),
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    getIt<ThemeCubit>().toggleTheme();
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Уведомления'),
              subtitle: const Text('Настроить push-уведомления'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Настройки уведомлений'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Язык'),
              subtitle: const Text('Русский'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Выбор языка'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.high_quality),
              title: const Text('Качество видео'),
              subtitle: const Text('Авто'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Настройки качества'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('О приложении'),
              subtitle: const Text('Версия 1.0.0'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CineOnline',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.movie_filter,
                    size: 48,
                  ),
                  children: const [
                    Text('Онлайн-кинотеатр для просмотра фильмов.'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

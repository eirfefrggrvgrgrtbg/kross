import 'package:flutter/material.dart';

import 'pages/loading_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/detail_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/main_navigation_page.dart';

class AppRoutes {
  static const String loading = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
        loading: (context) => const LoadingPage(),
        login: (context) => const LoginPage(),
        register: (context) => const RegisterPage(),
        main: (context) => const MainNavigationPage(),
        home: (context) => const HomePage(),
        profile: (context) => const ProfilePage(),
        settings: (context) => const SettingsPage(),
      };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final movieId = settings.arguments as int?;
      return MaterialPageRoute(
        builder: (context) => DetailPage(movieId: movieId ?? 0),
      );
    }
    return null;
  }
}


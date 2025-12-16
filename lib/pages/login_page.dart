import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_text_field.dart';
import '../data/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      UserService.instance.login(
        email: _emailController.text,
      );
      Navigator.of(context).pushReplacementNamed(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.movie_filter,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'CineOnline',
                    style: TextStyle(
                      fontFamily: 'CustomFont',
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Войдите в аккаунт',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  AppTextField(
                    controller: _emailController,
                    labelText: 'Email',
                    hintText: 'example@mail.com',
                    prefixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: AppValidators.email,
                    focusNode: _emailFocusNode,
                    nextFocusNode: _passwordFocusNode,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _passwordController,
                    labelText: 'Пароль',
                    hintText: 'Введите пароль',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: AppValidators.password,
                    focusNode: _passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _login,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Войти',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.register);
                    },
                    child: const Text('Нет аккаунта? Зарегистрироваться'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_text_field.dart';
import '../data/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      UserService.instance.register(
        fullName: _fullNameController.text,
        email: _emailController.text,
      );
      Navigator.of(context).pushReplacementNamed(AppRoutes.main);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
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
                    Icons.person_add,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Создайте аккаунт',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  AppTextField(
                    controller: _fullNameController,
                    labelText: 'ФИО',
                    hintText: 'Иванов Иван Иванович',
                    prefixIcon: Icons.person,
                    validator: AppValidators.fullName,
                    focusNode: _fullNameFocusNode,
                    nextFocusNode: _emailFocusNode,
                  ),
                  const SizedBox(height: 16),
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
                    hintText: 'Минимум 6 символов',
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    validator: AppValidators.password,
                    focusNode: _passwordFocusNode,
                    nextFocusNode: _confirmPasswordFocusNode,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    controller: _confirmPasswordController,
                    labelText: 'Подтвердите пароль',
                    hintText: 'Повторите пароль',
                    prefixIcon: Icons.lock_outline,
                    isPassword: true,
                    validator:
                        AppValidators.confirmPassword(_passwordController),
                    focusNode: _confirmPasswordFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _register(),
                  ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _register,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Зарегистрироваться',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Уже есть аккаунт? Войти'),
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


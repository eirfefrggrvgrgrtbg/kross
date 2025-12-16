import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool enabled;

  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.enabled = true,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
      ),
      validator: widget.validator,
      onFieldSubmitted: (value) {
        if (widget.nextFocusNode != null) {
          FocusScope.of(context).requestFocus(widget.nextFocusNode);
        }
        widget.onFieldSubmitted?.call(value);
      },
    );
  }
}

// Валидаторы
class AppValidators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Это поле обязательно для заполнения';
    }
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите ФИО';
    }
    final regex = RegExp(r'^[a-zA-Zа-яА-ЯёЁ\s]+$');
    if (!regex.hasMatch(value)) {
      return 'ФИО должно содержать только буквы и пробелы';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Введите email';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Введите корректный email';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите пароль';
    }
    if (value.length < 6) {
      return 'Пароль должен быть не менее 6 символов';
    }
    final hasLetters = RegExp(r'[a-zA-Zа-яА-ЯёЁ]').hasMatch(value);
    final hasDigits = RegExp(r'\d').hasMatch(value);
    final hasSpecial = RegExp(r'[_\-!@#$%^&*(),.?":{}|<>]').hasMatch(value);
    if (!hasLetters || !hasDigits || !hasSpecial) {
      return 'Пароль должен содержать буквы, цифры и символы (_-)';
    }
    return null;
  }

  static String? Function(String?) confirmPassword(
      TextEditingController passwordController) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Подтвердите пароль';
      }
      if (value != passwordController.text) {
        return 'Пароли не совпадают';
      }
      return null;
    };
  }
}


class Validators {
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите свое имя';
    }

    return null;
  }

  static String? validateSurname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введите свою фамилию';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email не может быть пустым';
    }
    if (!_emailRegex.hasMatch(value)) {
      return 'Введите корректный email';
    }
    return null;
  }

  // Валидация пароля
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Пароль не может быть пустым';
    }
    if (value.length < 8) {
      return 'Пароль должен быть не менее 8 символов';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Пароль должен содержать хотя бы одну заглавную букву';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Пароль должен содержать хотя бы одну цифру';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Пароль должен содержать хотя бы один спецсимвол';
    }
    return null;
  }
}

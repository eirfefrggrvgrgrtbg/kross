class UserService {
  static final UserService _instance = UserService._internal();
  static UserService get instance => _instance;

  UserService._internal();

  String? _fullName;
  String? _email;
  bool _isLoggedIn = false;

  String? get fullName => _fullName;
  String? get email => _email;
  bool get isLoggedIn => _isLoggedIn;

  void register({
    required String fullName,
    required String email,
  }) {
    _fullName = fullName;
    _email = email;
    _isLoggedIn = true;
  }

  void login({
    required String email,
  }) {
    _email = email;
    _isLoggedIn = true;
  }

  void logout() {
    _fullName = null;
    _email = null;
    _isLoggedIn = false;
  }

  void updateProfile({
    String? fullName,
    String? email,
  }) {
    if (fullName != null) _fullName = fullName;
    if (email != null) _email = email;
  }
}


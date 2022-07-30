class AuthService {
  static final AuthService _instance = AuthService._internal();

  // passes the instantiation to the _instance object
  factory AuthService() {
    return _instance;
  }

  //initialize variables in here
  AuthService._internal() {}

  bool _isLoggedIn = false;
  bool _isEmailVerified = false;

  bool get isLoggedIn => _isLoggedIn;
  bool get isEmailVerified => _isEmailVerified;

  set isLoggedIn(bool value) => isLoggedIn = value;
  set isEmailVerified(bool value) => _isEmailVerified = value;

  void setIsLoggedIn(value) {
    _isLoggedIn = value;
  }

  void setIsEmailVerified(value) {
    _isEmailVerified = value;
  }
}

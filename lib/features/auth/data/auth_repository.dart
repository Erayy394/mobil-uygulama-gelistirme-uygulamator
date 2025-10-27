import '../domain/user.dart';
import 'auth_api.dart';

/// Authentication repository
class AuthRepository {
  final AuthApi _authApi;

  User? _currentUser;

  AuthRepository(this._authApi);

  /// Get current user
  User? get currentUser => _currentUser;

  /// Initialize auth state
  Future<void> initialize() async {
    _currentUser = _authApi.getCurrentUser();
  }

  /// Sign in with email
  Future<User> signInWithEmail(String email, String password) async {
    try {
      final user = await _authApi.signInWithEmail(email, password);
      _currentUser = user;
      return user;
    } catch (e) {
      throw Exception('Giriş başarısız: $e');
    }
  }

  /// Sign up with email
  Future<User> signUpWithEmail(String email, String password,
      {String? name}) async {
    try {
      final user = await _authApi.signUpWithEmail(email, password, name: name);
      _currentUser = user;
      return user;
    } catch (e) {
      throw Exception('Kayıt başarısız: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await _authApi.signOut();
    _currentUser = null;
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _authApi.resetPassword(email);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => _currentUser != null;
}

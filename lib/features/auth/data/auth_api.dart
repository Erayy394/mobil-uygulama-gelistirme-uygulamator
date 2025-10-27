import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import '../domain/user.dart';

/// Authentication API implementation using Supabase
class AuthApi {
  final SupabaseClient _client;

  AuthApi(this._client);

  /// Get current user
  User? getCurrentUser() {
    final authUser = _client.auth.currentUser;
    if (authUser == null) return null;

    return User(
      id: authUser.id,
      email: authUser.email ?? '',
    );
  }

  /// Sign in with email and password
  Future<User> signInWithEmail(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Giriş başarısız');
    }

    return User(
      id: response.user!.id,
      email: response.user!.email ?? '',
    );
  }

  /// Sign up with email and password
  Future<User> signUpWithEmail(String email, String password,
      {String? name}) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Kayıt başarısız');
    }

    return User(
      id: response.user!.id,
      email: response.user!.email ?? '',
    );
  }

  /// Sign out
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }

  /// Get auth state changes stream
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}

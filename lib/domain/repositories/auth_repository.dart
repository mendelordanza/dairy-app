import '../models/auth_user.dart';

abstract class AuthRepository {
  AuthUser currentUser = AuthUser.empty;

  Stream<AuthUser> get fetchUserChanges;

  Future<void> signUpWithEmail({
    required String email,
    required String password,
  });

  Future<void> signInWithEmail({
    required String email,
    required String password,
  });

  Future<void> signInWithGoogle();

  Future<void> signInWithApple();

  Future<void> logout();
}

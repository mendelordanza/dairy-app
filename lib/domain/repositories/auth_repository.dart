import '../models/user_model.dart';

abstract class AuthRepository {
  UserModel currentUser = UserModel.empty;

  Stream<UserModel> get fetchUserChanges;

  Future<bool> signUpWithEmail({
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

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:night_diary/domain/models/user_model.dart';
import 'package:night_diary/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl(this.firebaseAuth);

  @override
  Stream<UserModel> get fetchUserChanges {
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      final user =
          firebaseUser == null ? UserModel.empty : firebaseUser.toAuthUser;
      currentUser = user;
      return user;
    });
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final appleAuthProvider = AppleAuthProvider();
      await firebaseAuth.signInWithProvider(appleAuthProvider);
    } on FirebaseAuthException {
      print("Something went wrong.");
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      await firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException {
      print("Something went wrong.");
    }
  }

  @override
  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      print("Something went wrong.");
    }
  }

  @override
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException {
      print("Something went wrong.");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException {
      print("Something went wrong.");
    }
  }
}

extension on User {
  UserModel get toAuthUser {
    return UserModel(
      id: uid,
      email: email,
      name: displayName,
    );
  }
}

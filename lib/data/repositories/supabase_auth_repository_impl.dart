import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:night_diary/domain/models/user_model.dart';
import 'package:night_diary/helper/constants.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/repositories/auth_repository.dart';

class SupabaseAuthRepositoryImpl extends AuthRepository {
  final FlutterAppAuth appAuth;
  final SupabaseClient supabaseClient;

  SupabaseAuthRepositoryImpl(this.appAuth, this.supabaseClient);

  @override
  Stream<UserModel> get fetchUserChanges {
    return supabaseClient.auth.onAuthStateChange.map((data) {
      final Session? session = data.session;
      currentUser =
          session != null ? UserModel(id: session.user.id) : UserModel.empty;
      return currentUser;
    });
  }

  @override
  Future<void> signInWithApple() async {
    try {
      final response = await supabaseClient.auth.signInWithApple();
      print("SESSION: ${response.session!.user}");
    } on AuthException catch (e) {
      print("Something went wrong. ${e}");
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final rawNonce = _generateRandomString();
      final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

      final platform = await PackageInfo.fromPlatform();
      String clientId = Platform.isIOS ? IOS_CLIENT_ID : ANDROID_CLIENT_ID;
      if (platform.packageName.contains(".dev")) {
        clientId = DEV_CLIENT_ID;
      }

      /// Set as reversed DNS form of Google Client ID + `:/` for Google login
      final redirectUrl = '${clientId.split('.').reversed.join('.')}:/';

      /// Fixed value for google login
      const discoveryUrl =
          'https://accounts.google.com/.well-known/openid-configuration';

      // authorize the user by opening the concent page
      final result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          nonce: hashedNonce,
          scopes: [
            'openid',
            'email',
            'profile',
          ],
        ),
      );

      if (result == null) {
        throw 'No result';
      }

      // Request the access and id token to google
      final tokenResult = await appAuth.token(
        TokenRequest(
          clientId,
          redirectUrl,
          authorizationCode: result.authorizationCode,
          discoveryUrl: discoveryUrl,
          codeVerifier: result.codeVerifier,
          nonce: result.nonce,
          scopes: [
            'openid',
            'email',
          ],
        ),
      );

      final idToken = tokenResult?.idToken;

      if (idToken == null) {
        throw 'No idToken';
      }

      await supabaseClient.auth.signInWithIdToken(
        provider: Provider.google,
        idToken: idToken,
        nonce: rawNonce,
      );
    } catch (e) {
      print("$e Something went wrong.");
    }
  }

  @override
  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      print("SESSION: ${response.session!.user}");
    } on AuthException catch (e) {
      print("Something went wrong. ${e}");
    }
  }

  @override
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
      );
      return response.user != null;
    } on AuthException catch (e) {
      print("Something went wrong. ${e}");
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  String _generateRandomString() {
    final random = Random.secure();
    return base64Url.encode(List<int>.generate(16, (_) => random.nextInt(256)));
  }
}

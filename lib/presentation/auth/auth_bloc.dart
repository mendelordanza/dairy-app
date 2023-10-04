import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<UserModel>? _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(
          authRepository.currentUser.isNotEmpty
              ? AuthState.authenticated(authRepository.currentUser)
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(_getAuthStateChange);
    on<SignInWithGoogle>(_signInWithGoogle);
    on<SignInWithApple>(_signInWithApple);
    on<SignInWithEmail>(_signInWithEmail);
    on<SignUpWithEmail>(_signUpWithEmail);
    on<LogoutRequest>(_logout);

    _userSubscription = _authRepository.fetchUserChanges.listen(
      (user) => add(AppUserChanged(user)),
    );
  }

  _getAuthStateChange(AppUserChanged event, Emitter<AuthState> emit) {
    emit(
      event.user.isNotEmpty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated(),
    );
  }

  _signInWithApple(SignInWithApple event, Emitter<AuthState> emit) {
    _authRepository.signInWithApple();
  }

  _signInWithGoogle(SignInWithGoogle event, Emitter<AuthState> emit) {
    _authRepository.signInWithGoogle();
  }

  _signInWithEmail(SignInWithEmail event, Emitter<AuthState> emit) {
    _authRepository.signInWithEmail(
        email: event.email, password: event.password);
  }

  _signUpWithEmail(SignUpWithEmail event, Emitter<AuthState> emit) {
    _authRepository.signUpWithEmail(
        email: event.email, password: event.password);
  }

  _logout(LogoutRequest event, Emitter<AuthState> emit) {
    unawaited(_authRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

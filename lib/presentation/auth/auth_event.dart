part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AppUserChanged extends AuthEvent {
  final AuthUser user;

  const AppUserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class SignInWithGoogle extends AuthEvent {}

class SignInWithApple extends AuthEvent {}

class SignInWithEmail extends AuthEvent {
  final String email;
  final String password;

  const SignInWithEmail({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class SignUpWithEmail extends AuthEvent {
  final String email;
  final String password;

  const SignUpWithEmail({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequest extends AuthEvent {}

part of 'auth_bloc.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
  loading,
  needConfirmation,
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserModel user;

  const AuthState._({
    required this.status,
    this.user = UserModel.empty,
  });

  const AuthState.authenticated(UserModel user)
      : this._(
          status: AuthStatus.authenticated,
          user: user,
        );

  const AuthState.unauthenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  const AuthState.loading()
      : this._(
          status: AuthStatus.loading,
        );

  const AuthState.needConfirmation()
      : this._(
          status: AuthStatus.needConfirmation,
        );

  @override
  List<Object> get props => [status, user];
}

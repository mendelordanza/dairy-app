part of 'local_auth_cubit.dart';

@immutable
abstract class LocalAuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalAuthInitial extends LocalAuthState {}

class LocalAuthSuccess extends LocalAuthState {}

class LocalAuthFailure extends LocalAuthState {}

class LocalAuthBiometricsDisabled extends LocalAuthState {}

class LocalAuthBiometricsEnabled extends LocalAuthState {}

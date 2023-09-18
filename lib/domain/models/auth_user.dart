import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String? email;
  final String? name;

  const AuthUser({required this.id, this.email, this.name});

  static const empty = AuthUser(id: '');

  bool get isEmpty => this == AuthUser.empty;

  bool get isNotEmpty => this != AuthUser.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        email,
        name,
      ];
}

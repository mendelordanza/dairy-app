import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? email;
  final String? name;

  const UserModel({required this.id, this.email, this.name});

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        email,
        name,
      ];
}

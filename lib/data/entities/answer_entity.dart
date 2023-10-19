import 'package:isar/isar.dart';

part 'answer_entity.g.dart';

@collection
class AnswerEntity {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? answer;
  String? quote;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answer': answer,
      'quote': quote,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

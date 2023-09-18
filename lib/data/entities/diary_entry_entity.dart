import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/answer_entity.dart';

part 'diary_entry_entity.g.dart';

@collection
class DiaryEntryEntity {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? createdAt;
  String? updatedAt;
  var answers = IsarLinks<AnswerEntity>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'answers': answers.map((e) => e.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

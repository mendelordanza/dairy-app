import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/diary_entry_entity.dart';

part 'answer_entity.g.dart';

@collection
class AnswerEntity {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  String? diaryEntryId;

  @Backlink(to: "answers")
  var diaryEntry = IsarLink<DiaryEntryEntity>();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'diaryEntryId': diaryEntryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
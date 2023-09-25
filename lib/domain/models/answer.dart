import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/answer_entity.dart';
import 'package:night_diary/domain/models/diary_entry.dart';

part 'answer.freezed.dart';

part 'answer.g.dart';

@freezed
sealed class Answer with _$Answer {
  const Answer._();

  const factory Answer({
    int? id,
    @JsonKey(name: "decrypted_answer") String? answer,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? quote,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  AnswerEntity toIsar({required DiaryEntry diaryEntry}) {
    final isarObject = AnswerEntity()
      ..id = id != null ? id! : Isar.autoIncrement
      ..answer = answer
      ..diaryEntry.value = diaryEntry.toIsar()
      ..createdAt = createdAt?.toIso8601String()
      ..updatedAt = updatedAt?.toIso8601String();
    return isarObject;
  }
}

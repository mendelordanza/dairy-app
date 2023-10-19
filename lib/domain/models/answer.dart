import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/answer_entity.dart';

part 'answer.freezed.dart';

part 'answer.g.dart';

@freezed
sealed class Answer with _$Answer {
  const Answer._();

  const factory Answer({
    int? id,
    String? answer,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? quote,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);

  AnswerEntity toIsar() {
    final isarObject = AnswerEntity()
      ..id = id != null ? id! : Isar.autoIncrement
      ..answer = answer
      ..quote = quote
      ..createdAt = createdAt?.toIso8601String()
      ..updatedAt = updatedAt?.toIso8601String();
    return isarObject;
  }
}

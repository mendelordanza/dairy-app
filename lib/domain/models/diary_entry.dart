import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../../data/entities/diary_entry_entity.dart';
import 'answer.dart';

part 'diary_entry.freezed.dart';

part 'diary_entry.g.dart';

@freezed
sealed class DiaryEntry with _$DiaryEntry {
  const DiaryEntry._();

  const factory DiaryEntry({
    int? id,
    @Default([]) List<Answer> answers,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _DiaryEntry;

  factory DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$DiaryEntryFromJson(json);

  DiaryEntryEntity toIsar() {
    final isarObject = DiaryEntryEntity()
      ..id = id != null ? id! : Isar.autoIncrement
      ..createdAt = createdAt?.toIso8601String()
      ..updatedAt = updatedAt?.toIso8601String();
    return isarObject;
  }
}

DateTime _sendAtFromJson(Timestamp timestamp) =>
    DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);

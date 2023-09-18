// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryEntry _$$_DiaryEntryFromJson(Map<String, dynamic> json) =>
    _$_DiaryEntry(
      id: json['id'] as int?,
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => Answer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$_DiaryEntryToJson(_$_DiaryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'answers': instance.answers,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

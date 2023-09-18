// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryEntry _$DiaryEntryFromJson(Map<String, dynamic> json) {
  return _DiaryEntry.fromJson(json);
}

/// @nodoc
mixin _$DiaryEntry {
  int? get id => throw _privateConstructorUsedError;
  List<Answer> get answers => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryEntryCopyWith<DiaryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryEntryCopyWith<$Res> {
  factory $DiaryEntryCopyWith(
          DiaryEntry value, $Res Function(DiaryEntry) then) =
      _$DiaryEntryCopyWithImpl<$Res, DiaryEntry>;
  @useResult
  $Res call(
      {int? id,
      List<Answer> answers,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$DiaryEntryCopyWithImpl<$Res, $Val extends DiaryEntry>
    implements $DiaryEntryCopyWith<$Res> {
  _$DiaryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? answers = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      answers: null == answers
          ? _value.answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiaryEntryCopyWith<$Res>
    implements $DiaryEntryCopyWith<$Res> {
  factory _$$_DiaryEntryCopyWith(
          _$_DiaryEntry value, $Res Function(_$_DiaryEntry) then) =
      __$$_DiaryEntryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      List<Answer> answers,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$_DiaryEntryCopyWithImpl<$Res>
    extends _$DiaryEntryCopyWithImpl<$Res, _$_DiaryEntry>
    implements _$$_DiaryEntryCopyWith<$Res> {
  __$$_DiaryEntryCopyWithImpl(
      _$_DiaryEntry _value, $Res Function(_$_DiaryEntry) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? answers = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_DiaryEntry(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      answers: null == answers
          ? _value._answers
          : answers // ignore: cast_nullable_to_non_nullable
              as List<Answer>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiaryEntry extends _DiaryEntry {
  const _$_DiaryEntry(
      {this.id,
      final List<Answer> answers = const [],
      this.createdAt,
      this.updatedAt})
      : _answers = answers,
        super._();

  factory _$_DiaryEntry.fromJson(Map<String, dynamic> json) =>
      _$$_DiaryEntryFromJson(json);

  @override
  final int? id;
  final List<Answer> _answers;
  @override
  @JsonKey()
  List<Answer> get answers {
    if (_answers is EqualUnmodifiableListView) return _answers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answers);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DiaryEntry(id: $id, answers: $answers, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiaryEntry &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._answers, _answers) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_answers), createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiaryEntryCopyWith<_$_DiaryEntry> get copyWith =>
      __$$_DiaryEntryCopyWithImpl<_$_DiaryEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiaryEntryToJson(
      this,
    );
  }
}

abstract class _DiaryEntry extends DiaryEntry {
  const factory _DiaryEntry(
      {final int? id,
      final List<Answer> answers,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$_DiaryEntry;
  const _DiaryEntry._() : super._();

  factory _DiaryEntry.fromJson(Map<String, dynamic> json) =
      _$_DiaryEntry.fromJson;

  @override
  int? get id;
  @override
  List<Answer> get answers;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_DiaryEntryCopyWith<_$_DiaryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:night_diary/domain/models/answer.dart';

abstract class DiaryEntryRepository {
  Future<List<Answer>> loadEntries();

  Future<Answer?> addEntry({required Answer answer});

  Future<void> editEntry();

  Future<void> deleteEntry();
}

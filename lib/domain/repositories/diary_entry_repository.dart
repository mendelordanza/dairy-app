import 'package:night_diary/domain/models/diary_entry.dart';

abstract class DiaryEntryRepository {
  Future<List<DiaryEntry>> loadEntries();

  Future<int> addEntry({required DiaryEntry diaryEntry});

  Future<void> editEntry();

  Future<void> deleteEntry();
}

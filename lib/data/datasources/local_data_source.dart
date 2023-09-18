import 'package:night_diary/data/isar_service.dart';

import '../../domain/models/answer.dart';
import '../../domain/models/diary_entry.dart';

abstract class LocalDataSource {
  Future<List<DiaryEntry>> loadEntries();

  Future<int> addEntry({required DiaryEntry diaryEntry});

  Future<int> addAnswer({
    required DiaryEntry diaryEntry,
    required Answer answer,
  });

  Future<void> editEntry();

  Future<void> deleteEntry();
}

class LocalDataSourceImpl extends LocalDataSource {
  final IsarService _isarService;

  LocalDataSourceImpl(this._isarService);

  @override
  Future<int> addEntry({required DiaryEntry diaryEntry}) async {
    return await _isarService.saveDiaryEntry(diaryEntry.toIsar());
  }

  @override
  Future<void> deleteEntry() {
    // TODO: implement deleteEntry
    throw UnimplementedError();
  }

  @override
  Future<void> editEntry() {
    // TODO: implement editEntry
    throw UnimplementedError();
  }

  @override
  Future<List<DiaryEntry>> loadEntries() async {
    final entries = await _isarService.getAllEntries();
    return entries;
  }

  @override
  Future<int> addAnswer(
      {required DiaryEntry diaryEntry, required Answer answer}) async {
    return await _isarService.saveAnswer(answer.toIsar(diaryEntry: diaryEntry));
  }
}

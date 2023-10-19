import 'package:night_diary/domain/models/answer.dart';

abstract class DiaryEntryRepository {
  Future<List<Answer>> loadEntries();

  Future<int> addEntry({required Answer answer});

  Future<int> editEntry({required Answer answer});

  Future<bool> deleteEntry({required int id});
}

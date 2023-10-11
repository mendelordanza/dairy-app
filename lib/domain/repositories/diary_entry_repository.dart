import 'package:night_diary/domain/models/answer.dart';

abstract class DiaryEntryRepository {
  Future<List<Answer>> loadEntries();

  Future<Answer?> addEntry({required Answer answer});

  Future<Answer?> editEntry({required Answer answer});

  Future<int?> deleteEntry({required int id});
}

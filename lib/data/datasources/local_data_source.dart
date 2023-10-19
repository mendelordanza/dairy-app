import 'package:night_diary/data/isar_service.dart';

import '../../domain/models/answer.dart';

abstract class LocalDataSource {
  Future<List<Answer>> loadEntries();

  Future<int> addAnswer({required Answer answer});

  Future<int> editEntry({required Answer answer});

  Future<bool> deleteEntry({required int answerId});
}

class LocalDataSourceImpl extends LocalDataSource {
  final IsarService _isarService;

  LocalDataSourceImpl(this._isarService);

  @override
  Future<bool> deleteEntry({required int answerId}) async {
    return await _isarService.deleteDiaryEntry(answerId);
  }

  @override
  Future<int> editEntry({required Answer answer}) async {
    return await _isarService.saveAnswer(answer.toIsar());
  }

  @override
  Future<List<Answer>> loadEntries() async {
    final entries = await _isarService.getAllEntries();
    return entries.map((e) => Answer.fromJson(e.toJson())).toList();
  }

  @override
  Future<int> addAnswer({required Answer answer}) async {
    return await _isarService.saveAnswer(answer.toIsar());
  }
}

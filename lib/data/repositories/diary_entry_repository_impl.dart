import 'package:night_diary/data/datasources/local_data_source.dart';
import 'package:night_diary/domain/models/answer.dart';

import '../../domain/repositories/diary_entry_repository.dart';

class DiaryEntryRepositoryImpl extends DiaryEntryRepository {
  final LocalDataSource localDataSource;

  //final RemoteDataSource remoteDataSource;

  DiaryEntryRepositoryImpl(this.localDataSource);

  @override
  Future<int> addEntry({required Answer answer}) async {
    final data = await localDataSource.addAnswer(answer: answer);
    return data;
  }

  @override
  Future<bool> deleteEntry({required int id}) async {
    return await localDataSource.deleteEntry(answerId: id);
  }

  @override
  Future<int> editEntry({required Answer answer}) async {
    return await localDataSource.editEntry(answer: answer);
  }

  @override
  Future<List<Answer>> loadEntries() async {
    return await localDataSource.loadEntries();
  }
}

import 'package:night_diary/data/datasources/local_data_source.dart';
import 'package:night_diary/domain/models/answer.dart';

import '../../domain/repositories/diary_entry_repository.dart';
import '../datasources/remote_data_source.dart';

class DiaryEntryRepositoryImpl extends DiaryEntryRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  DiaryEntryRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<Answer?> addEntry({required Answer answer}) async {
    final data = await remoteDataSource.addEntry(answer: answer);
    return data;
  }

  @override
  Future<int?> deleteEntry({required int id}) async {
    return await remoteDataSource.deleteEntry(id: id);
  }

  @override
  Future<Answer?> editEntry({required Answer answer}) async {
    return await remoteDataSource.editEntry(answer: answer);
  }

  @override
  Future<List<Answer>> loadEntries() async {
    return await remoteDataSource.loadEntries();
  }
}

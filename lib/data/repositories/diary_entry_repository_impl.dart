import 'package:night_diary/data/datasources/local_data_source.dart';
import 'package:night_diary/domain/models/answer.dart';

import '../../domain/repositories/diary_entry_repository.dart';
import '../datasources/remote_data_source.dart';

class DiaryEntryRepositoryImpl extends DiaryEntryRepository {
  final LocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;

  DiaryEntryRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<int> addEntry({required Answer answer}) async {
    //final entry =  await localDataSource.addEntry(diaryEntry: diaryEntry);
    // final id = await localDataSource.addAnswer(
    //   diaryEntry: diaryEntry,
    //   answer: diaryEntry.answers[0],
    // );
    // return id;
    await remoteDataSource.addEntry(answer: answer);
    return 1;
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
  Future<List<Answer>> loadEntries() async {
    return await remoteDataSource.loadEntries();
  }
}

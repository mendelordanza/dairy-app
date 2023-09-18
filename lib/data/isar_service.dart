import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/answer_entity.dart';
import 'package:night_diary/data/entities/diary_entry_entity.dart';
import 'package:night_diary/domain/models/diary_entry.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<List<DiaryEntry>> getAllEntries() async {
    final isar = await db;
    final list = await isar.diaryEntryEntitys.where().findAll();
    return list.map((e) => DiaryEntry.fromJson(e.toJson())).toList();
  }

  Future<int> saveDiaryEntry(DiaryEntryEntity diaryEntryEntity) async {
    final isar = await db;
    final id = isar.writeTxnSync<int>(
        () => isar.diaryEntryEntitys.putSync(diaryEntryEntity));
    return id;
  }

  Future<int> saveAnswer(AnswerEntity answerEntity) async {
    final isar = await db;
    final id = isar.writeTxnSync<int>(() => isar.answerEntitys.putSync(answerEntity));
    return id;
  }

  Future<void> deleteDiaryEntry(int diaryEntryId) async {
    final isar = await db;
    await isar.writeTxn(() async {
      final success = await isar.diaryEntryEntitys.delete(diaryEntryId);
      print('deleted: $success');
    });
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          DiaryEntryEntitySchema,
          AnswerEntitySchema,
        ],
        inspector: true,
        directory: dir.path,
      );
    }
    return Future.value(Isar.getInstance());
  }
}

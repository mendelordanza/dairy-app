import 'package:isar/isar.dart';
import 'package:night_diary/data/entities/answer_entity.dart';
import 'package:night_diary/data/entities/diary_entry_entity.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<List<AnswerEntity>> getAllEntries() async {
    final isar = await db;
    final list = await isar.answerEntitys.where().findAll();
    return list;
  }

  Future<int> saveAnswer(AnswerEntity answerEntity) async {
    final isar = await db;
    final id =
        isar.writeTxnSync<int>(() => isar.answerEntitys.putSync(answerEntity));
    return id;
  }

  Future<bool> deleteDiaryEntry(int answerId) async {
    final isar = await db;
    final deleted =
        await isar.writeTxn(() => isar.answerEntitys.delete(answerId));
    return deleted;
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

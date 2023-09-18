import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:night_diary/domain/models/answer.dart';

import '../../domain/models/diary_entry.dart';

abstract class RemoteDataSource {
  Future<List<DiaryEntry>> loadEntries();

  Future<void> addEntry({required DiaryEntry diaryEntry});

  Future<void> editEntry();

  Future<void> deleteEntry();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseFirestore firestore;

  RemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addEntry({required DiaryEntry diaryEntry}) {
    // TODO: implement addEntry
    throw UnimplementedError();
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
    // final entriesRf = firestore
    //     .collection("users")
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("entries");
    //
    // final querySnapshotEntries = await entriesRf
    //     .withConverter<DiaryEntry>(
    //         fromFirestore: (snapshot, _) =>
    //             DiaryEntry.fromJson(snapshot.data()!),
    //         toFirestore: (diaryEntry, _) => diaryEntry.toJson())
    //     .get();
    // final entries = querySnapshotEntries.docs.map((e) => e.data()).toList();
    //
    // List<DiaryEntry> newEntries = [];
    // for (var entry in entries) {
    //   final querySnapshotAnswers = await entriesRf
    //       .doc(entry.id)
    //       .collection("answers")
    //       .withConverter<Answer>(
    //           fromFirestore: (snapshot, _) =>
    //               Answer.fromJson(snapshot.data()!),
    //           toFirestore: (answer, _) => answer.toJson())
    //       .get();
    //   final answers = querySnapshotAnswers.docs.map((e) => e.data()).toList();
    //   final newEntry = entries
    //       .singleWhere((element) => element.id == entry.id)
    //       .copyWith(answers: answers);
    //   newEntries.add(newEntry);
    // }
    //
    // return newEntries;

    // TODO: implement editEntry
    throw UnimplementedError();
  }
}

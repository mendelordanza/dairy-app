import 'package:night_diary/domain/models/answer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDataSource {
  Future<List<Answer>> loadEntries();

  Future<void> addEntry({required Answer answer});

  Future<void> editEntry();

  Future<void> deleteEntry();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<void> addEntry({required Answer answer}) async {
    if (supabaseClient.auth.currentUser != null) {
      await supabaseClient.from("answers").insert({
        "answer": answer.answer,
        "createdAt": DateTime.now().toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
        "user_id": supabaseClient.auth.currentUser?.id,
      });
    }
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
    final data = await supabaseClient
        .from("decrypted_answers")
        .select("*")
        .eq("user_id", supabaseClient.auth.currentUser?.id);
    print("DATA: $data");
    return List.from(data).map((e) => Answer.fromJson(e)).toList();
  }
}

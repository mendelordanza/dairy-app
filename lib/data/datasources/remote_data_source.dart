import 'package:night_diary/domain/models/answer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RemoteDataSource {
  Future<List<Answer>> loadEntries();

  Future<Answer?> addEntry({required Answer answer});

  Future<void> editEntry();

  Future<void> deleteEntry();
}

class RemoteDataSourceImpl extends RemoteDataSource {
  final SupabaseClient supabaseClient;

  RemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<Answer?> addEntry({required Answer answer}) async {
    final response = await supabaseClient.from("answers").insert({
      "answer": answer.answer,
      "created_at": DateTime.now().toIso8601String(),
      "updated_at": DateTime.now().toIso8601String(),
      "user_id": supabaseClient.auth.currentUser?.id,
    }).select();
    return Answer.fromJson(response[0]);
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
        .from("answers")
        .select("*")
        .eq("user_id", supabaseClient.auth.currentUser?.id);
    return List.from(data).map((e) => Answer.fromJson(e)).toList();
  }
}

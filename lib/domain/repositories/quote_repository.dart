import 'package:night_diary/helper/data_state.dart';

abstract class QuoteRepository {
  Future<DataState<String>> generateQuote({required String prompt});

  Future<void> saveQuote({required int answerId, required String quote});
}

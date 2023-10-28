import 'package:night_diary/helper/data_state.dart';

import '../models/answer.dart';

abstract class QuoteRepository {
  Future<DataState<Map<String, String>>> generateQuote(
      {required String prompt});

  Future<void> saveQuote({required Answer answer, required String quote});
}

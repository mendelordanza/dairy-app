import 'package:night_diary/helper/data_state.dart';

import '../models/answer.dart';

abstract class QuoteRepository {
  Future<DataState<String>> generateQuote({required String prompt});

  Future<void> saveQuote({required Answer answer, required String quote});
}

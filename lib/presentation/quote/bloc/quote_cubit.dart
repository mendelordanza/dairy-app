import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:night_diary/helper/data_state.dart';

import '../../../domain/repositories/quote_repository.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteCubit({required this.quoteRepository}) : super(QuoteInitial());

  generateQuote({required String prompt}) async {
    emit(QuoteLoading());
    final response = await quoteRepository.generateQuote(prompt: prompt);
    if (response is DataSuccess && response.data != null) {
      emit(QuoteGenerated(response.data!));
    } else if (response is DataFailed) {
      emit(QuoteError("${response.error}"));
    } else {
      emit(QuoteInitial());
    }
  }
}

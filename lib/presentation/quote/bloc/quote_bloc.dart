import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:night_diary/helper/data_state.dart';
import 'package:night_diary/helper/extensions/string.dart';
import 'package:night_diary/presentation/quote/bloc/quote_event.dart';

import '../../../domain/repositories/quote_repository.dart';

part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository quoteRepository;

  QuoteBloc({required this.quoteRepository}) : super(QuoteInitial()) {
    on<GenerateQuote>(generateQuote);
    on<SaveQuote>(saveQuote);
    on<ResetQuote>(resetQuote);
    on<ResetCount>(resetCount);
  }

  int totalGeneratedQuote = 0;

  resetCount(ResetCount event, Emitter emit) {
    totalGeneratedQuote = 0;
  }

  resetQuote(ResetQuote event, Emitter emit) {
    emit(QuoteInitial());
  }

  generateQuote(GenerateQuote event, Emitter emit) async {
    emit(QuoteLoading());

    //Check for problematic entries
    if (event.prompt.hasProblematicEntry()) {
      emit(QuoteGenerated(
          "For now, I would recommend to seek for professional help"));
    } else {
      final response =
          await quoteRepository.generateQuote(prompt: event.prompt);
      if (response is DataSuccess && response.data != null) {
        totalGeneratedQuote++;
        emit(QuoteGenerated('"${response.data!}"'));
      } else if (response is DataFailed) {
        emit(QuoteError("${response.error}"));
      } else {
        emit(QuoteInitial());
      }
    }
  }

  saveQuote(SaveQuote event, Emitter emit) async {
    await quoteRepository.saveQuote(answer: event.answer, quote: event.quote);
    emit(QuoteSaved());
  }
}

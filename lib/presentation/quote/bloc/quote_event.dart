import 'package:equatable/equatable.dart';

import '../../../domain/models/answer.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ResetQuote extends QuoteEvent {}

class ResetCount extends QuoteEvent {}

class GenerateQuote extends QuoteEvent {
  final String prompt;

  const GenerateQuote(this.prompt);
}

class SaveQuote extends QuoteEvent {
  final Answer answer;
  final String quote;

  const SaveQuote(this.answer, this.quote);
}

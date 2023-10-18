import 'package:equatable/equatable.dart';

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

  GenerateQuote(this.prompt);
}

class SaveQuote extends QuoteEvent {
  final int answerId;
  final String quote;

  SaveQuote(this.answerId, this.quote);
}

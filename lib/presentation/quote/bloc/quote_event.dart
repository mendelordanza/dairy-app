import 'package:equatable/equatable.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GenerateQuote extends QuoteEvent {
  final String prompt;

  GenerateQuote(this.prompt);
}

class SaveQuote extends QuoteEvent {
  final int answerId;
  final String quote;

  SaveQuote(this.answerId, this.quote);
}

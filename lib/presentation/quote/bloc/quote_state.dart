part of 'quote_bloc.dart';

@immutable
abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteGenerated extends QuoteState {
  final String quote;

  QuoteGenerated(this.quote);
}

class QuoteLoading extends QuoteState {}

class QuoteError extends QuoteState {
  final String message;

  QuoteError(this.message);
}

class QuoteSaved extends QuoteState {}

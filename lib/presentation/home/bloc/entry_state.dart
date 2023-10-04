part of 'entry_bloc.dart';

abstract class EntryState extends Equatable {
  const EntryState();

  @override
  List<Object?> get props => [];
}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryAdded extends EntryState {
  final int answerId;
  final String text;

  EntryAdded(
    this.answerId,
    this.text,
  );
}

class EntryLoaded extends EntryState {
  final List<Answer> entries;

  EntryLoaded(this.entries);

  @override
  List<Object?> get props => [entries];
}

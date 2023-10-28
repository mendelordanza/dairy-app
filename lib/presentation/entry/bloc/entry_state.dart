part of 'entry_bloc.dart';

abstract class EntryState extends Equatable {
  const EntryState();

  @override
  List<Object?> get props => [];
}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryAdded extends EntryState {
  final Answer answer;

  const EntryAdded(
    this.answer,
  );

  @override
  List<Object?> get props => [answer];
}

class EntryLoaded extends EntryState {
  final List<Answer> entries;

  const EntryLoaded(this.entries);

  @override
  List<Object?> get props => [entries];
}

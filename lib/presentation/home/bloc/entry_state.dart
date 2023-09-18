part of 'entry_bloc.dart';

abstract class EntryState extends Equatable {
  const EntryState();
}

class EntryInitial extends EntryState {
  @override
  List<Object> get props => [];
}

class EntryLoading extends EntryState {
  @override
  List<Object?> get props => [];
}

class EntryLoaded extends EntryState {
  final List<DiaryEntry> entries;

  EntryLoaded(this.entries);

  @override
  // TODO: implement props
  List<Object?> get props => [entries];
}

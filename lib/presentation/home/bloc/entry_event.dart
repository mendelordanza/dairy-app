part of 'entry_bloc.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadEntries extends EntryEvent {}

class AddEntry extends EntryEvent {
  final Answer answer;

  AddEntry(this.answer);

  @override
  List<Object> get props => [answer];
}

class UpdateEntry extends EntryEvent {}

class DeleteEntry extends EntryEvent {}

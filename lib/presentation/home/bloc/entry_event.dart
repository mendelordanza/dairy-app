part of 'entry_bloc.dart';

abstract class EntryEvent extends Equatable {
  const EntryEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class LoadEntries extends EntryEvent {
}

class AddEntry extends EntryEvent {
  final DiaryEntry diaryEntry;

  AddEntry(this.diaryEntry);

  @override
  List<Object> get props => [diaryEntry];
}

class UpdateEntry extends EntryEvent {
}

class DeleteEntry extends EntryEvent {
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:night_diary/domain/models/answer.dart';

import '../../../domain/repositories/diary_entry_repository.dart';

part 'entry_event.dart';

part 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final DiaryEntryRepository diaryEntryRepository;

  EntryBloc(this.diaryEntryRepository) : super(EntryInitial()) {
    on<LoadEntries>(loadEntries);
    on<AddEntry>(addEntry);
    on<EditEntry>(editEntry);
    on<DeleteEntry>(deleteEntry);

    add(LoadEntries());
  }

  loadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    final entries = await diaryEntryRepository.loadEntries();
    entries.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
    emit(EntryLoaded(entries));
  }

  addEntry(AddEntry event, Emitter<EntryState> emit) async {
    final answerId = await diaryEntryRepository.addEntry(answer: event.answer);
    emit(EntryAdded(event.answer.copyWith(id: answerId)));
  }

  editEntry(EditEntry event, Emitter<EntryState> emit) async {
    final answerId = await diaryEntryRepository.editEntry(answer: event.answer);
    emit(EntryAdded(event.answer.copyWith(id: answerId)));
  }

  deleteEntry(DeleteEntry event, Emitter<EntryState> emit) async {
    final deleted = await diaryEntryRepository.deleteEntry(id: event.id);
    if (deleted) {
      final currentState = state as EntryLoaded;
      List<Answer> newEntries = List.from(currentState.entries)
        ..removeWhere((element) => element.id == event.id);
      emit(EntryLoaded(newEntries));
    }
  }
}

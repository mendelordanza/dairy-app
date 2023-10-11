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
    final answer = await diaryEntryRepository.addEntry(answer: event.answer);
    if (answer != null) {
      emit(EntryAdded(answer.id!, event.answer.answer!));
      add(LoadEntries());
    }
  }

  editEntry(EditEntry event, Emitter<EntryState> emit) async {
    final answer = await diaryEntryRepository.editEntry(answer: event.answer);
    if (answer != null) {
      emit(EntryAdded(answer.id!, event.answer.answer!));
      add(LoadEntries());
    }
  }

  deleteEntry(DeleteEntry event, Emitter<EntryState> emit) async {
    final id = await diaryEntryRepository.deleteEntry(id: event.id);
    if (id != null) {
      print("ID: $id");
      final currentState = state as EntryLoaded;
      List<Answer> newEntries = List.from(currentState.entries)
        ..removeWhere((element) => element.id == id);
      emit(EntryLoaded(newEntries));
    }
  }
}

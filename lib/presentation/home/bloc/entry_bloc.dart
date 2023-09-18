import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/models/diary_entry.dart';
import '../../../domain/repositories/diary_entry_repository.dart';

part 'entry_event.dart';

part 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final DiaryEntryRepository diaryEntryRepository;

  EntryBloc(this.diaryEntryRepository) : super(EntryInitial()) {
    on<LoadEntries>(loadEntries);
    on<AddEntry>(addEntry);
    add(LoadEntries());
  }

  loadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    final entries = await diaryEntryRepository.loadEntries();
    print("ENTRIES: ${entries}");
    emit(EntryLoaded(entries));
  }

  addEntry(AddEntry event, Emitter<EntryState> emit) async {
    await diaryEntryRepository.addEntry(diaryEntry: event.diaryEntry);
    final newEntries = await diaryEntryRepository.loadEntries();
    emit(EntryLoaded(newEntries));
  }
}

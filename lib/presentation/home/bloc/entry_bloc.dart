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
  }

  loadEntries(LoadEntries event, Emitter<EntryState> emit) async {
    emit(EntryLoading());
    final entries = await diaryEntryRepository.loadEntries();
    entries.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
    emit(EntryLoaded(entries));
  }

  addEntry(AddEntry event, Emitter<EntryState> emit) async {
    await diaryEntryRepository.addEntry(answer: event.answer);
    add(LoadEntries());
  }
}

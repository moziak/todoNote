import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:meta/meta.dart';
import 'package:note/domain/note/i_note_repository.dart';
import 'package:note/domain/note/note.dart';
import 'package:note/domain/note/note_failure.dart';

part 'note_watcher_event.dart';
part 'note_watcher_state.dart';

part 'note_watcher_bloc.freezed.dart';
class NoteWatcherBloc extends Bloc<NoteWatcherEvent, NoteWatcherState> {
  
  final INoteRepository _noteRepository;

  NoteWatcherBloc(this._noteRepository);

  StreamSubscription<Either<NoteFailure, KtList<Note>>> _noteStreamSubscription;

  @override
  NoteWatcherState get initialState => const NoteWatcherState.initial();

  @override
  Stream<NoteWatcherState> mapEventToState(
    NoteWatcherEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository
            .watchAll()
            .listen((notes) => add(NoteWatcherEvent.notesReceived(notes)));
      },
      watchUncompletedStarted: (e) async* {
        yield const NoteWatcherState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository
            .watchUncompleted()
            .listen((notes) => add(NoteWatcherEvent.notesReceived(notes)));
      },
      notesReceived: (e) async* {
        yield e.failureOrNotes.fold(
          (f) => NoteWatcherState.loadFailure(f),
          (notes) => NoteWatcherState.loadSuccess(notes),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _noteStreamSubscription.cancel();
    return super.close();
  }
}

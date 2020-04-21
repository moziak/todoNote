import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:note/domain/note/i_note_repository.dart';
import 'package:note/domain/note/note.dart';
import 'package:note/domain/note/note_failure.dart';

part 'note_actor_event.dart';
part 'note_actor_state.dart';

part 'note_actor_bloc.freezed.dart';

@injectable
class NoteActorBloc extends Bloc<NoteActorEvent, NoteActorState> {
  

  final INoteRepository _noteRepository;

  NoteActorBloc(this._noteRepository);

  @override
  NoteActorState get initialState => const NoteActorState.initial();

  @override
  Stream<NoteActorState> mapEventToState(
    NoteActorEvent event,
  ) async* {
    // We have only one NoteActorEvent - there's no union type
    yield const NoteActorState.actionInProgress();
    final possibleFailure = await _noteRepository.delete(event.note);
    yield possibleFailure.fold(
      (f) => NoteActorState.deleteFailure(f),
      // Yielding unchanged state - nothing will be emitted from the BLoC
      (_) => const NoteActorState.deleteSuccess(),
    );
  }
}

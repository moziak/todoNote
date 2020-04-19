import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:note/domain/core/entity.dart';
import 'package:note/domain/core/value_objects.dart';
import 'package:note/domain/note/value_object.dart';
import 'package:note/domain/note/todo_item.dart';

part 'note.freezed.dart';

@freezed
abstract class Note with _$Note{
  const factory Note({
    @required UniqueId id,
    @required NoteBody body,
    @required NoteColor color,
    @required List3<TodoItem> todos,
  }) = _Note;

  factory Note.empty() => Note(
    id: UniqueId(),
    body: NoteBody(''),
    color: NoteColor(NoteColor.predefinedColors[0]),
    todos: List3(emptyList()),
  );
}
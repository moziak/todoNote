
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/core/failures.dart';
import 'package:note/domain/core/value_objects.dart';
import 'package:note/domain/note/value_object.dart';

part 'todo_item.freezed.dart';

@freezed
abstract class TodoItem with _$TodoItem{
   const factory TodoItem({
    @required UniqueId id,
    @required TodoName name,
        @required bool done,
      }) = _TodoItem;
    
  factory TodoItem.empty() => TodoItem(
        id: UniqueId(),
        name: TodoName(''),
        done: false,
      );
}

extension TodoItemX on TodoItem{
  Option<ValueFailure<dynamic>> get failureOption => name.failureOrUnit
  .fold((f) => some(f), (_) => none());
}   
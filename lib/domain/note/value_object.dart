import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:note/domain/core/failures.dart';
import 'package:note/domain/core/value_objects.dart';
import 'package:note/domain/core/value_validators.dart';
import 'package:note/domain/core/value_transformer.dart';


class NoteBody extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;

  static const maxLength = 1000;

  factory NoteBody(String input){
    
    return NoteBody._(validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty));
  }

  const NoteBody._(this.value);
}

class NoteName extends ValueObject<String>{
  @override
  final Either<ValueFailure<String>, String> value;

  factory NoteName(String input){
    
    return NoteName._(validateStringNotEmpty(input));
  }

  const NoteName._(this.value);
  
}

class NoteColor extends ValueObject<Color> {
  static const List<Color> predefinedColors = [
    Color(0xfffafafa), // canvas
    Color(0xfffa8072), // salmon
    Color(0xfffedc56), // mustard
    Color(0xffd0f0c0), // tea
    Color(0xfffca3b7), // flamingo
    Color(0xff997950), // tortilla
    Color(0xfffffdd0), // cream
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  factory NoteColor(Color input) {
    assert(input != null);
    return NoteColor._(
      right(makeColorOpaque(input)),
    );
  }

  const NoteColor._(this.value);
}

class List3<T> extends ValueObject<KtList<T>> {
  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  static const maxLength = 3;

  factory List3(KtList<T> input) {
    assert(input != null);
    return List3._(
      validateMaxListLength(input, maxLength),
    );
  }

  const List3._(this.value);

  int get length {
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
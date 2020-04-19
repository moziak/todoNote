import 'package:dartz/dartz.dart';
import 'package:uuid/uuid.dart';
import 'package:note/domain/core/errors.dart';

import 'failures.dart';
import 'value_validators.dart';

abstract class ValueObject<T>{
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  bool isValid()=> value.isRight(); 

  T getOrElse(T dflt) {
    return value.getOrElse(() => dflt);
  }

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw UnexpectedValueError(f), id);
  }

  @override
  bool operator == (Object o){
    if(identical(this, o)) return true;

    return o is ValueObject<T> &&  o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'T($value)';
}
class StringSingleLine extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory StringSingleLine(String input) {
    assert(input != null);
    return StringSingleLine._(
      validateSingleLine(input),
    );
  }

  const StringSingleLine._(this.value);
}

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  // We cannot let a simple String be passed in. This would allow for possible non-unique IDs.
  factory UniqueId() {
    return UniqueId._(
      right(Uuid().v1()),
    );
  }

  factory UniqueId.fromFirebaseId(String firebaseId) {
    assert(firebaseId != null);
    return UniqueId._(
      right(firebaseId),
    );
  }

  const UniqueId._(this.value);
}


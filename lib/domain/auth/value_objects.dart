import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/core/failures.dart';
import 'package:note/domain/core/value_objects.dart';
import 'package:note/domain/core/value_validators.dart';

@immutable
class EmailAddress extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input){
   assert(input != null);
   return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);

}

@immutable
class Password extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  factory Password(String input){
   assert(input != null);
   return Password._(validatePassword(input));
  }

  const Password._(this.value);

}
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note/domain/core/failures.dart';
import 'package:note/domain/core/value_objects.dart';


@immutable
class EmailAddress extends ValueObject<String>{
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input){
   assert(input != null);
   return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);

}


Either<ValueFailure<String>, String> validateEmailAddress(String email){
  const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if(RegExp(emailRegex).hasMatch(email)){
    return right(email);
  }else{
    return left(ValueFailure.invalidEmail(failedValue: email));
  }
}





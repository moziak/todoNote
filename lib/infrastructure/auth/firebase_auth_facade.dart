import 'package:note/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:note/domain/auth/i_auth_facade.dart';
import 'package:note/domain/auth/value_objects.dart';

class FirebaseAuthFacade implements IAuthFacade{
  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({EmailAddress emailAddress, Password password}) {
    // TODO: implement registerWithEmailAndPassword
    throw UnimplementedError();
  }
  
    
  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({EmailAddress emailAddress, Password password}) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }
  
}
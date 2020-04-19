import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:note/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:note/domain/auth/i_auth_facade.dart';
import 'package:note/domain/auth/user.dart';
import 'package:note/domain/auth/value_objects.dart';
import 'package:note/infrastructure/auth/firebase_user_mapper.dart';

@prod
@lazySingleton
@RegisterAs(IAuthFacade)
@injectable
class FirebaseAuthFacade implements IAuthFacade{

  final FirebaseAuth _firebaseAuth;
  FirebaseUserMapper _firebaseUserMapper;
  FirebaseAuthFacade(this._firebaseAuth, this._firebaseUserMapper);
  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({@required EmailAddress emailAddress, @required Password password}) async {
    final emailAddressStr = emailAddress.value.getOrElse(() => 'Inalid Email');
    final passwordStr = password.value.getOrElse(() => 'Invalid Password');
    
    try {
       return await _firebaseAuth.createUserWithEmailAndPassword(email: emailAddressStr, password: passwordStr)
       .then((_) => Right(unit));
    } on PlatformException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        return left(const AuthFailure.emailAlreadyInUse());
      }else{
        return left(const AuthFailure.serverError());
      }
    }
  }
  
    
  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({EmailAddress emailAddress, Password password}) async {
    final emailAddressStr = emailAddress.value.getOrElse(() => 'INVALID EMAIL');
    final passwordStr = password.value.getOrElse(() => 'INVALID PASSWORD');

    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: emailAddressStr, password: passwordStr)
      .then((_) => right(unit));
    } catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD' ||
          e.code == 'ERROR_USER_NOT_FOUND') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      }
      return left(const AuthFailure.serverError());
    }
    
  }

  @override
  Future<Option<User>> getSignedInUser() => _firebaseAuth.currentUser().then((u) => optionOf(_firebaseUserMapper.toDomain(u)));

  @override
  Future<void> signOut() async {
    return Future.wait([
      //_googleSignIn.signOut(),
      _firebaseAuth.signOut(),
    ]);
  }
  
}
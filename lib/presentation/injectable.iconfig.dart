// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:note/infrastructure/auth/firebase_user_mapper.dart';
import 'package:note/infrastructure/auth/firebase_auth_facade.dart';
import 'package:note/domain/auth/i_auth_facade.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  g.registerLazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<IAuthFacade>(
        () => FirebaseAuthFacade(g<FirebaseAuth>(), g<FirebaseUserMapper>()));
  }
}

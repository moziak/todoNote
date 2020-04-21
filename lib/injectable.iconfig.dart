// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:note/infrastructure/core/firebase_injectable.dart';
import 'package:note/infrastructure/auth/firebase_user_mapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note/infrastructure/auth/firebase_auth_facade.dart';
import 'package:note/domain/auth/i_auth_facade.dart';
import 'package:note/infrastructure/note/note_repository.dart';
import 'package:note/domain/note/i_note_repository.dart';
import 'package:note/application/note/note_actor/note_actor_bloc.dart';
import 'package:note/application/note/note_form/note_form_bloc.dart';
import 'package:note/application/note/note_watcher/note_watcher_bloc.dart';
import 'package:note/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:note/application/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  g.registerLazySingleton<FirebaseAuth>(
      () => firebaseInjectableModule.firebaseAuth);
  g.registerLazySingleton<FirebaseUserMapper>(() => FirebaseUserMapper());
  g.registerLazySingleton<Firestore>(() => firebaseInjectableModule.firestore);
  g.registerFactory<NoteActorBloc>(() => NoteActorBloc(g<INoteRepository>()));
  g.registerFactory<NoteFormBloc>(() => NoteFormBloc(g<INoteRepository>()));
  g.registerFactory<NoteWatcherBloc>(
      () => NoteWatcherBloc(g<INoteRepository>()));
  g.registerFactory<SignInFormBloc>(() => SignInFormBloc(g<IAuthFacade>()));
  g.registerFactory<AuthBloc>(() => AuthBloc(g<IAuthFacade>()));

  //Register prod Dependencies --------
  if (environment == 'prod') {
    g.registerLazySingleton<IAuthFacade>(
        () => FirebaseAuthFacade(g<FirebaseAuth>(), g<FirebaseUserMapper>()));
    g.registerLazySingleton<INoteRepository>(
        () => NoteRepository(g<Firestore>()));
  }
}

class _$FirebaseInjectableModule extends FirebaseInjectableModule {}

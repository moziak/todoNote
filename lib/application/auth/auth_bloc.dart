import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:note/domain/auth/i_auth_facade.dart';
import 'package:note/domain/auth/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final IAuthFacade _authFacade;
  AuthBloc(this._authFacade);

  @override
  AuthState get initialState => AuthState.initial();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    yield* event.map(
      authCheckRequested: (_) async* {
        final userOption = await _authFacade.getSignedInUser();
        print(userOption);
        yield userOption.fold(() => const AuthState.unauthenticated(), (user) =>  AuthState.authenticated(user));
      },
      signedOut: (_) async*{
        await _authFacade.signOut();
        yield const AuthState.unauthenticated();
      }
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:note/application/auth/auth_bloc.dart';
import 'package:note/application/note/note_actor/note_actor_bloc.dart';
import 'package:note/application/note/note_watcher/note_watcher_bloc.dart';
import 'package:note/injectable.dart';
import 'package:note/presentation/routes/router.gr.dart';
import 'package:note/presentation/screens/note/note_overview/widget/note_overview_body_widget.dart';
import 'package:note/presentation/screens/note/note_overview/widget/uncompleted_switch.dart';

class NoteScreen extends HookWidget implements AutoRouteWrapper {
  @override
  Widget get wrappedRoute => MultiBlocProvider(
        providers: [
          BlocProvider<NoteWatcherBloc>(
            create: (context) => getIt<NoteWatcherBloc>()
              ..add(const NoteWatcherEvent.watchAllStarted()),
          ),
          BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>(),
          ),
        ],
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeMap(
              unauthenticated: (_) =>
                ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.signInScreen),
              orElse: () {},
            );
          },
        ),
        BlocListener<NoteActorBloc, NoteActorState>(
          listener: (context, state) {
            state.maybeMap(
              deleteFailure: (state) {
                FlushbarHelper.createError(
                  duration: const Duration(seconds: 5),
                  message: state.noteFailure.map(
                      // Use localized strings here in your apps
                      insufficientPermissions: (_) =>
                          'Insufficient permissions ❌',
                      unableToUpdate: (_) => 'Impossible error',
                      unexpected: (_) =>
                          'Unexpected error occured while deleting, please contact support.'),
                ).show(context);
              },
              orElse: () {},
            );
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          leading: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
            },
          ),
          actions: <Widget>[
            UncompletedSwitch(),
          ],
        ),
        body: NotesOverviewBody(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ExtendedNavigator.ofRouter<Router>().pushNamed(Routes.noteFormScreen);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
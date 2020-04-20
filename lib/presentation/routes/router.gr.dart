// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:note/presentation/screens/splash.dart';
import 'package:note/presentation/screens/sign_in_form.dart';
import 'package:note/presentation/screens/note_screen.dart';
import 'package:note/presentation/screens/note/note_form/note_form_screen.dart';
import 'package:note/domain/note/note.dart';

abstract class Routes {
  static const splashScreen = '/';
  static const signInScreen = '/sign-in-screen';
  static const noteScreen = '/note-screen';
  static const noteFormScreen = '/note-form-screen';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SplashScreen(),
          settings: settings,
        );
      case Routes.signInScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => SignInScreen(),
          settings: settings,
        );
      case Routes.noteScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => NoteScreen().wrappedRoute,
          settings: settings,
        );
      case Routes.noteFormScreen:
        if (hasInvalidArgs<NoteFormScreenArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<NoteFormScreenArguments>(args);
        }
        final typedArgs = args as NoteFormScreenArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => NoteFormScreen(
              key: typedArgs.key, editedNote: typedArgs.editedNote),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//NoteFormScreen arguments holder class
class NoteFormScreenArguments {
  final Key key;
  final Note editedNote;
  NoteFormScreenArguments({this.key, @required this.editedNote});
}

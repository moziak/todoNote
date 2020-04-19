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

abstract class Routes {
  static const splashScreen = '/';
  static const signInScreen = '/sign-in-screen';
  static const noteScreen = '/note-screen';
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
          builder: (_) => NoteScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

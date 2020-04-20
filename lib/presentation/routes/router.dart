import 'package:auto_route/auto_route_annotations.dart';
import 'package:note/presentation/screens/note/note_form/note_form_screen.dart';
import 'package:note/presentation/screens/sign_in_form.dart';
import 'package:note/presentation/screens/splash.dart';
import 'package:note/presentation/screens/note_screen.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashScreen splashScreen;
  SignInScreen signInScreen;
  NoteScreen noteScreen;
  NoteFormScreen noteFormScreen;
}
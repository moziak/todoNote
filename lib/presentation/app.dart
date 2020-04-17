import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/application/auth/auth_bloc.dart';
import 'package:note/presentation/routes/router.gr.dart';

import '../injectable.dart';

class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(AuthEvent.authCheckRequested()))
      ],
      child: MaterialApp(
        title: 'Note App',
        theme: ThemeData(
          
          primarySwatch: Colors.blue,
        ),
        builder: ExtendedNavigator<Router>(router: Router(),),
      ),
    );
  }
}
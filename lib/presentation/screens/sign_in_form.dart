import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/application/auth/auth_bloc.dart';
import 'package:note/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:note/injectable.dart';
import 'package:note/presentation/routes/router.gr.dart';
import 'package:styled_widget/styled_widget.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Form"),
      ),
      
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: BlocConsumer<SignInFormBloc, SignInFormState>(
          listener: (context, state){
            state.authFailureOrSuccessOption.fold(
              () {}, 
              (either){
                either.fold((failure){
                  return Flushbar(
                    message: failure.map(
                      cancelledByUser: (_) => "CANCEL BY USER", 
                      serverError: (_) => "System Clinch, Please Contant your administratir", 
                      emailAlreadyInUse: (_) => 'Email already in use', 
                      invalidEmailAndPasswordCombination: (_) =>
                          'Invalid email and password combination'),
                  ).show(context);
                }, 
                (r){
                  print("Successful");
                  ExtendedNavigator.ofRouter<Router>().pushReplacementNamed(Routes.noteScreen);
                  context.bloc<AuthBloc>().add(AuthEvent.authCheckRequested());
                });
              });
          },
          builder: (context, state){
            return Form(
              autovalidate: state.showErrorMessages,
              child: ListView(
                children: <Widget>[
                  const Text(
                  '📝',
                  ).textAlignment(TextAlign.center).fontSize(130),
                  const SizedBox(height: 8),

                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    onChanged: (e){
                      context.bloc<SignInFormBloc>().add(SignInFormEvent.emailChanged(e));
                    },
                    
                    validator: (_) => state.emailAddress.value.fold(
                      (f) => f.maybeMap(
                        invalidEmail: (_) => 'Invalid email',
                        orElse: () => null,
                      ),
                      (_) => null,
                      
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                  // controller: passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    autocorrect: false,
                    onChanged: (value) => context.bloc<SignInFormBloc>().add(SignInFormEvent.passwordChanged(value)),
                    validator: (_)=> state.password.value.fold(
                      (f) => f.maybeMap(
                        shortPassword: (_) => "Short Password",
                        orElse: () => null
                      ), 
                      (r) => null
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FlatButton(
                          onPressed: () => context.bloc<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed()),
                          child: const Text('SIGN IN'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FlatButton(
                          onPressed: () => context.bloc<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .registerWithEmailAndPasswordPressed()),
                          child: const Text('REGISTER'),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            );
          }, 
        ),
      ),
    );
  }
}
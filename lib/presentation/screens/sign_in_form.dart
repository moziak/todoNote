import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn Form"),
      ),
      
      body: BlocConsumer<SignInFormBloc, SignInFormState>(
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
              (r) => (){});
            });
        },
        builder: null, 
      ),
    );
  }
}
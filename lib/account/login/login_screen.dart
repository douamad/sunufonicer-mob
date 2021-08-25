import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunufoncier/account/login/bloc/login_bloc.dart';
import 'package:sunufoncier/keys.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sunufoncier/routes.dart';
import 'package:sunufoncier/shared/repository/http_utils.dart';
import 'package:formz/formz.dart';

import 'bloc/login_models.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: SunufoncierKeys.mainScreen);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state.status.isSubmissionSuccess){
          Navigator.pushNamed(context, SunufoncierRoutes.main);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title:Text('Bienvenu à SenFoncier'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[
              header(context),
              loginForm(),
              Padding(
                padding: EdgeInsets.only(bottom: 50),
              ),
              //register(context)
            ]),
          )),
    );
  }

  Widget header(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(image: AssetImage('assets/images/senfoncierlogo.png'),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width * 0.4,),
        Padding(padding: EdgeInsets.symmetric(vertical: 20)),
        Image(image: AssetImage('assets/images/directionimpotlogo.png'),
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width * 0.4,),
        Padding(padding: EdgeInsets.symmetric(vertical: 20))
      ],
    );
  }

  Widget loginField() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.login != current.login,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.login.value,
              onChanged: (value) { context.read<LoginBloc>().add(LoginChanged(login: value)); },
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText:'Login',
                  errorText: state.login.invalid ? LoginValidationError.invalid.invalidMessage : null));
        });
  }

  Widget passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen:(previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextFormField(
              initialValue: state.password.value,
              onChanged: (value) { context.read<LoginBloc>().add(PasswordChanged(password: value)); },
              obscureText: true,
              decoration: InputDecoration(
                  labelText:'Mot de passe',
                  errorText: state.password.invalid ? PasswordValidationError.invalid.invalidMessage : null));
        });
  }

  Widget loginForm() {
    return Form(
          child: Wrap(runSpacing: 15, children: <Widget>[
            loginField(),
            passwordField(),
            validationZone(),
            submit()
          ]),
        );
  }

  /* Widget register(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.red),
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Center(
            child: Text('Register'.toUpperCase()            ),
          )),
      onPressed: () => Navigator.pushNamed(context, SunufoncierRoutes.register),
    );
  }
 */
  Widget validationZone() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen:(previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Visibility(
              visible: state.status.isSubmissionFailure,
              child: Center(
                child: Text(
                  generateError(state, context),
                  style: TextStyle(fontSize: Theme.of(context).textTheme.bodyText1!.fontSize, color: Theme.of(context).errorColor),
                  textAlign: TextAlign.center,
                ),
              ));
        });
  }

  Widget submit() {
    return BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return ElevatedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Center(
                        child: Visibility(
                          replacement: CircularProgressIndicator(value: null),
                          visible: !state.status.isSubmissionInProgress,
                    child: Text('Sign in'.toUpperCase()),
                        ),
                      )
                    ),
            onPressed: state.status.isValidated
                ? () => context.read<LoginBloc>().add(FormSubmitted()) : null,
          );
        });
  }

  String generateError(LoginState state, BuildContext context) {
    String errorTranslated = '';
    if (state.generalErrorKey.toString().compareTo(LoginState.authenticationFailKey) == 0) {
                        errorTranslated ='Problème lors de l\'authentification, vérifiez vos informations d\'identification';
    } else if (state.generalErrorKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      errorTranslated ='Something wrong when calling the server, please try again';
    }
    return errorTranslated;
  }
}

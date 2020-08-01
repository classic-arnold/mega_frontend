import 'package:flutter/material.dart';
import 'package:mega/components/BigText.dart';
import 'package:mega/components/forms/LoginForm.dart';

class LoginScreenArguments {
  final String email;

  LoginScreenArguments({this.email});
}

class LoginScreen extends StatelessWidget{
  static const routeName = '/login';

  @override
  Widget build(BuildContext context){
    final LoginScreenArguments args = ModalRoute.of(context).settings.arguments;
    return(
        Scaffold(
            body: Padding(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/img/logo/logo.png'),
                  Center(
                      child: Column(
                        children: <Widget>[
                          BigText(
                              text:'Login'
                          ),
                          Padding(
                            child: LoginForm(
                              email: args.email
                            ),
                            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                          )
                        ],
                      )
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              padding: EdgeInsets.all(30),
            )
        )
    );
  }
}
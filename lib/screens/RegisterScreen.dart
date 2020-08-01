import 'package:flutter/material.dart';
import 'package:mega/components/BigText.dart';
import 'package:mega/components/forms/LoginForm.dart';
import 'package:mega/components/forms/RegisterForm.dart';

class RegisterScreenArguments {
  final String email;

  RegisterScreenArguments({this.email});
}

class RegisterScreen extends StatelessWidget{
  static const routeName = '/register';

  @override
  Widget build(BuildContext context){
    final RegisterScreenArguments args = ModalRoute.of(context).settings.arguments;
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
                              text:'Register'
                          ),
                          Padding(
                            child: RegisterForm(
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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mega/components/buttons/my_submit_button.dart';
import 'package:mega/components/inputs/my_password_input.dart';
import 'package:mega/forms/login_form.dart';
import 'package:mega/components/texts/error_text.dart';
import 'package:mega/models/state_models/auth_token_state_model.dart';
import 'package:mega/models/response_models/login_response_model.dart';
import 'package:mega/models/response_models/register_response_model.dart';
import 'package:mega/services/api/base_api.dart';
import 'package:mega/services/api/auth_api.dart';
import 'package:mega/services/login.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatefulWidget{
  final String email;
  RegisterForm({this.email});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>{
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _errorText;

  void setErrorText(text){
    setState(() {
      _errorText = text;
    });
  }

  void submit() async {
    if (_formKey.currentState.validate()){
      // do login
      RegisterResponseModel _res = await AuthAPI.register(context, this.widget.email, _passwordController.text, setErrorText);

      // check successful registration
      if(_res != null) {
        doLogin(context, this.widget.email, _passwordController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(widget.email)
          ),
          MyPasswordInput(
            controller: _passwordController
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: MySubmitButton(
              buttonText: 'Register',
              submitCallback: submit
            )
          ),
          if(_errorText!=null) Align(
            alignment: Alignment.bottomLeft,
            child: ErrorText(_errorText),
          )
        ],
      )
    );
  }
}
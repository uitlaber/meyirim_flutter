import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/models/user.dart';
import 'package:meyirim/helpers/auth.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:meyirim/ui/input_decoration.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  String jwt = '';

  final _formKey = GlobalKey<FormState>();

  var phoneFormatter = new MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#00D7FF'),
        appBar: AppBar(
          backgroundColor: HexColor('#00D7FF'),
          elevation: 0,
          leading: new Container(
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('Home');
              },
            ),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      // mainAxisSize: MainAxisSize.max,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30.0),
                          child: Padding(
                            padding: EdgeInsets.only(left: 70.0, right: 70.0),
                            child: Image.asset('assets/images/logo.png'),
                          ),
                        ),
                        (_isLoading)
                            ? Center(
                                child: new CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white)),
                              )
                            : Column(
                                children: [
                                  TextFormField(
                                      keyboardType: TextInputType.phone,
                                      decoration: uiInputDecoration(
                                          hintText: '+7 (___) ___-__-__'),
                                      inputFormatters: [phoneFormatter]),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: true,
                                      decoration:
                                          uiInputDecoration(hintText: 'Пароль'),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: true,
                                      decoration: uiInputDecoration(
                                          hintText: 'Потвердите свой пароль'),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: Column(
                                      children: [
                                        ButtonTheme(
                                          height: 50.0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            // side: BorderSide(color: Colors.red)
                                          ),
                                          child: SizedBox(
                                            width: double.infinity,
                                            height: 50.0,
                                            child: RaisedButton(
                                              color: HexColor('#00748A'),
                                              textColor: Colors.white,
                                              onPressed: () async =>
                                                  await register(),
                                              elevation: 0,
                                              child: Text(
                                                "РЕГИСТРАЦИЯ",
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(10.0)),
                                        new InkWell(
                                            child: new Text(
                                                'Уже есть аккаунт? Войдите',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('Login')),
                                      ],
                                    ),
                                  )
                                ],
                              )
                      ],
                    ),
                  )),
            ),
          ),
        ));
  }

  // Проверка авторизации пользователя

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  void register() async {}
}

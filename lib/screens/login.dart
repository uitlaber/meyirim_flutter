import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'profile.dart';
import 'package:meyirim/helpers/api_manager.dart';
import 'file:///C:/Users/uitlaber/Desktop/meyirim_flutter/meyirim/lib/helpers/api_response.dart';
import 'package:meyirim/models/user.dart';
import 'package:meyirim/helpers/auth.dart' as auth;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  bool isAuth = false;
  String jwt = '';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   builder: build,
    // )
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
                  child: FormBuilder(
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
                        (_isLoading || jwt?.isNotEmpty ?? false)
                            ? Center(
                                child: new CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white)),
                              )
                            : Column(
                                children: [
                                  FormBuilderTextField(
                                    attribute: "email",
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        border: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                            borderSide: new BorderSide(
                                                color: Colors.transparent)),
                                        enabledBorder: new OutlineInputBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(30.0),
                                            ),
                                            borderSide: new BorderSide(
                                                color: Colors.transparent)),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[600]),
                                        hintText: "E-mail или номер телефона",
                                        fillColor: Colors.white),
                                    validators: [
                                      FormBuilderValidators.required(
                                          errorText:
                                              'Введите E-mail или Телефон'),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20.0),
                                    child: FormBuilderTextField(
                                      attribute: "password",
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              left: 20.0, right: 20.0),
                                          border: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(30.0),
                                              ),
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                          enabledBorder: new OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(30.0),
                                              ),
                                              borderSide: new BorderSide(
                                                  color: Colors.transparent)),
                                          filled: true,
                                          hintStyle: new TextStyle(
                                              color: Colors.grey[600]),
                                          hintText: "Пароль",
                                          fillColor: Colors.white),
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText: 'Введите пароль'),
                                        FormBuilderValidators.minLength(6,
                                            errorText:
                                                'Пароль должен содержать минимум 6 символов'),
                                      ],
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
                                                  await login(),
                                              elevation: 0,
                                              child: Text(
                                                "ВОЙТИ",
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
                                            child: new Text('Забыли пароль?',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white)),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('Reset')),
                                        Padding(padding: EdgeInsets.all(5.0)),
                                        new InkWell(
                                            child: new Text('Регистрация',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                )),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('Register')),
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

  void login() async {
    var errorMessage = '';
    if (_isLoading) return;
    SharedPreferences storage = await SharedPreferences.getInstance();
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      //
      // await auth.attemptLogIn(_formKey.currentState.value).then((authData) {
      //   auth.userData = User.fromJson(authData['user']);
      //   setState(() {
      //     jwt = authData['token'];
      //     _isLoading = false;
      //   });
      // }).catchError((e) {
      //   print(e);
      //   errorMessage = e.toString();
      //   setState(() {
      //     _isLoading = false;
      //     jwt = '';
      //   });
      // });

      var authData;
      try {
        authData = await auth.attemptLogIn(_formKey.currentState.value);
        auth.userData = User.fromJson(authData['user']);
        setState(() {
          jwt = authData['token'];
          _isLoading = false;
        });

        await storage.setString("user_code", auth.userData.userCode);
      }
      // on Exception1 {
      //   // code for handling exception
      // }
      catch (e) {
        print(e.toString());
        errorMessage = e.toString();
        setState(() {
          _isLoading = false;
          jwt = '';
        });
      }

      if (errorMessage?.isNotEmpty ?? false) {
        print(errorMessage);
        displayDialog(context, "Ошибка!", 'Не правильный логин или пароль');
        return;
      }

      if (jwt != null) {
        storage.setString("jwt", jwt);
        Navigator.of(context).pushNamed('Home');
      }
    } else {
      print("validation failed");
    }
  }
}

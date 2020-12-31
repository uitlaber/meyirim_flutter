import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/models/user.dart';
import 'package:meyirim/helpers/auth.dart' as auth;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  String jwt = '';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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
                                    child: FormBuilderTextField(
                                      attribute: "password_confirmation",
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
                                          hintText: "Потвердите пароль",
                                          fillColor: Colors.white),
                                      validators: [
                                        FormBuilderValidators.required(
                                            errorText: 'Потвердите пароль'),
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

  void register() async {
    var errorMessage = '';
    if (_isLoading) return;
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      var authData;
      try {
        authData = await auth.attemptRegister(_formKey.currentState.value);
        auth.userData = User.fromJson(authData['user']);
        setState(() {
          jwt = authData['token'];
          _isLoading = false;
        });
      } catch (e) {
        errorMessage = e.toString();
        setState(() {
          _isLoading = false;
          jwt = null;
        });
      }

      if (errorMessage?.isNotEmpty ?? false) {
        displayDialog(context, "Ошибка!", errorMessage);
        return;
      }
      if (jwt != null) {
        globals.storage.write(key: "jwt", value: jwt);
        Navigator.of(context).pushNamed('Home');
      }
    } else {
      print("validation failed");
    }
  }
}

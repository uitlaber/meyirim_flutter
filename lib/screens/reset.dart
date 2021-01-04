import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meyirim/models/user.dart';
import 'package:meyirim/ui/input_decoration.dart';
import 'package:meyirim/helpers/auth.dart' as auth;
import 'package:dio/dio.dart';
import 'dart:convert';

class ResetScreen extends StatefulWidget {
  ResetScreen({Key key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  bool _isLoading = false;
  bool isAuth = false;
  String jwt = '';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  var phoneFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
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
                                      name: "phone",
                                      keyboardType: TextInputType.phone,
                                      decoration: uiInputDecoration(
                                          hintText: '+7 (___) ___-__-__'),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context,
                                            errorText:
                                                'Введите номер телефона'),
                                        FormBuilderValidators.match(context,
                                            r'^\+7 \(([0-9]{3})\) ([0-9]{3})-([0-9]{2})-([0-9]{2})$',
                                            errorText:
                                                'Неверный номер телефона')
                                      ]),
                                      inputFormatters: [phoneFormatter]),
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
                                                  await reset(),
                                              elevation: 0,
                                              child: Text(
                                                "Восстановить пароль",
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
                                            child: new Text('Войти',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white)),
                                            onTap: () => Navigator.of(context)
                                                .pushNamed('Login')),
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
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(text),
          actions: [
            FlatButton(
              child: Text("Хорошо"),
              onPressed: () {
                Navigator.of(context).pushNamed('Login');
              },
            )
          ],
        ),
      );

  void reset() async {
    var errorMessage = '';
    if (_isLoading) return;
    SharedPreferences storage = await SharedPreferences.getInstance();
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      if (globals.lastReset != null) {
        print(globals.lastReset);
        var currentTime = DateTime.now().millisecondsSinceEpoch;
        var result = currentTime - globals.lastReset;
        print(result);
        if (result < 120000) {
          var n = ((120000 - result) / 1000).round();
          displayDialog(context, "Внимание",
              'Повторно можете отправить смс через $n секунд');
          return;
        }
      }
      setState(() => _isLoading = true);

      try {
        await auth.resetPassword(_formKey.currentState.value);
        displayDialog(context, "Внимание", 'Ваш новый пароль придет через смс');
        globals.lastReset = DateTime.now().millisecondsSinceEpoch;
        setState(() {
          _isLoading = false;
        });
      } on DioError catch (error) {
        Map<String, dynamic> response = jsonDecode(error.response.toString());
        errorMessage = response['error'];
        setState(() {
          _isLoading = false;
          jwt = null;
        });
      } catch (e) {
        errorMessage = e.toString();
        setState(() {
          _isLoading = false;
          jwt = '';
        });
      }

      if (errorMessage?.isNotEmpty ?? false) {
        displayDialog(context, "Ошибка!", errorMessage);
        return;
      }
    } else {
      print("validation failed");
    }
  }
}

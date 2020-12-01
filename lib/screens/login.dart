import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import '../helpers/hex_color.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#00D7FF'),
        appBar: AppBar(
          backgroundColor: HexColor('#00D7FF'),
          bottom: PreferredSize(
              child: Container(
                color: Colors.white60,
                height: 0.5,
              ),
              preferredSize: Size.fromHeight(0.5)),
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
          actions: <Widget>[
            // IconButton(icon: Icon(Icons.close, color: Colors.white, size: 32,), onPressed: () {
            //   Navigator.of(context)
            //       .pushNamed('Home');
            // },)
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: FormBuilder(
                  key: _fbKey,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 50.0),
                        child: Padding(
                          padding: EdgeInsets.only(left: 70.0, right: 70.0),
                          child: Image.asset('assets/images/logo.png'),
                        ),
                      ),
                      FormBuilderTextField(
                        attribute: "phone",
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20.0, right: 20.0),
                            border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            enabledBorder: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(30.0),
                                ),
                                borderSide:
                                    new BorderSide(color: Colors.transparent)),
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[600]),
                            hintText: "email или номер телефона",
                            fillColor: Colors.white),
                        validators: [
                          FormBuilderValidators.required(),
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
                              contentPadding:
                                  EdgeInsets.only(left: 20.0, right: 20.0),
                              border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                  borderSide: new BorderSide(
                                      color: Colors.transparent)),
                              enabledBorder: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(30.0),
                                  ),
                                  borderSide: new BorderSide(
                                      color: Colors.transparent)),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[600]),
                              hintText: "пароль",
                              fillColor: Colors.white),
                          validators: [
                            FormBuilderValidators.required(),
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
                                borderRadius: BorderRadius.circular(30.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50.0,
                                child: RaisedButton(
                                  color: HexColor('#00748A'),
                                  textColor: Colors.white,
                                  onPressed: () {},
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
                                        fontSize: 16.0, color: Colors.white)),
                                onTap: () =>
                                    Navigator.of(context).pushNamed('Reset')),
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
                  ),
                ))
          ],
        ));
  }
}

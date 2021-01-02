import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:meyirim/helpers/auth.dart' as auth;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  var phoneFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#EFEFF4'),
        appBar: AppBar(
          titleSpacing: 0,
          backgroundColor: HexColor('#00D7FF'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Редактировать профиль',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    FormBuilderImagePicker(
                        decoration: InputDecoration(
                          hintText: 'Фото',
                        ),
                        attribute: 'photo',
                        maxImages: 1,
                        key: UniqueKey(),
                        bottomSheetPadding: EdgeInsets.all(40)),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      attribute: "name",
                      key: UniqueKey(),
                      initialValue: auth.userData.name,
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
                          hintText: "Имя",
                          fillColor: Colors.white),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Введите Имя'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderDropdown(
                      attribute: 'region',
                      key: UniqueKey(),
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
                          fillColor: Colors.white),
                      // initialValue: 'Male',
                      allowClear: true,
                      hint: Text('Город или регион'),
                      items: regionOptions()
                          .map((region) => DropdownMenuItem(
                                value: region['id'],
                                child: Text(region['name']),
                              ))
                          .toList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      attribute: "email",
                      key: UniqueKey(),
                      initialValue: auth.userData.email,
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
                          hintText: "E-mail",
                          fillColor: Colors.white),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Введите E-mail'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                        attribute: "phone",
                        key: UniqueKey(),
                        keyboardType: TextInputType.phone,
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
                            hintText: "+7 (___) ___-__-__",
                            fillColor: Colors.white),
                        validators: [
                          FormBuilderValidators.required(
                              errorText: 'Введите телефон'),
                        ],
                        inputFormatters: [
                          phoneFormatter
                        ]),
                    SizedBox(
                      height: 20,
                    ),
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
                          onPressed: () => requestForm(),
                          elevation: 0,
                          child: Text(
                            "Отправить в фонды ",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        )));
  }

  List<Map<String, dynamic>> regionOptions() {
    List<Map<String, dynamic>> returnMap = [];
    returnMap.addAll([
      {'id': 1, 'name': 'Шымкент'}
    ]);

    return returnMap;
  }

  requestForm() async {
    var errorMessage = '';
    if (_isLoading) return;
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      setState(() => _isLoading = true);
      var url = globals.addIndigentUrl;
      var api = new APIManager();
      try {
        Map<String, dynamic> data = {
          'name': _formKey.currentState.value['name'],
          'region': _formKey.currentState.value['region'],
          'phone': _formKey.currentState.value['phone'],
          'email': _formKey.currentState.value['email'],
          'photo': Iterable<dynamic>.generate(
                  _formKey.currentState.value['photo'].length)
              .toList(),
        };

        for (var i = 0; i < _formKey.currentState.value['photo'].length; i++) {
          final mimeTypeData = lookupMimeType(
              _formKey.currentState.value['photo'][i].path,
              headerBytes: [0xFF, 0xD8]).split('/');
          data['photo'][i] = await MultipartFile.fromFile(
              _formKey.currentState.value['photo'][i].path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        }

        FormData formData = FormData.fromMap(data);

        await api.postAPICall(url, formData);
        _formKey.currentState.reset();

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushNamed('Profile');
      } catch (e) {
        errorMessage = e.toString();
        setState(() {
          _isLoading = false;
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

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}

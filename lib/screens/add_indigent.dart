import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class AddIndigentScreen extends StatefulWidget {
  @override
  _AddIndigentScreenState createState() => _AddIndigentScreenState();
}

class _AddIndigentScreenState extends State<AddIndigentScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#EFEFF4'),
        appBar: AppBar(
          title: Text('Назад'),
          titleSpacing: 0,
          backgroundColor: HexColor('#00D7FF'),
        ),
        body: SafeArea(
            child: Center(
                child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: FormBuilder(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Добавить нуждающего',
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
                      attribute: "fio",
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
                          hintText: "ФИО",
                          fillColor: Colors.white),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Введите ФИО'),
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
                      hint: Text('Город'),
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
                      attribute: "address",
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
                          hintText: "Адрес",
                          fillColor: Colors.white),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: 'Введите Адрес'),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      attribute: "note",
                      key: UniqueKey(),
                      maxLines: 5,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              top: 20, bottom: 20, left: 20.0, right: 20.0),
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
                          hintText: "Дополнительная информация  ",
                          fillColor: Colors.white),
                      validators: [],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FormBuilderTextField(
                      attribute: "phone",
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
                          hintText: "+7 (___) ___-__-__",
                          fillColor: Colors.white),
                      validators: [
                        FormBuilderValidators.required(
                            errorText: '+7 (___) ___-__-__'),
                      ],
                    ),
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
        ))));
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
          'fio': _formKey.currentState.value['fio'],
          'region': _formKey.currentState.value['region'],
          'address': _formKey.currentState.value['address'],
          'phone': _formKey.currentState.value['phone'],
          'note': _formKey.currentState.value['note'],
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
        displayDialog(context, "Спасибо!", 'Ваш запрос отправлен!');
        // print(response);
        setState(() {
          _isLoading = false;
        });
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

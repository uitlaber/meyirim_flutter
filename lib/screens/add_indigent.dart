import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/ui/input_decoration.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meyirim/models/region.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIndigentScreen extends StatefulWidget {
  @override
  _AddIndigentScreenState createState() => _AddIndigentScreenState();
}

class _AddIndigentScreenState extends State<AddIndigentScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<Region> regions;
  var phoneFormatter = new MaskTextInputFormatter(
      mask: '+# (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    fetchRegionOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#EFEFF4'),
        appBar: AppBar(
          title: Text('Добавить нуждающегося'),
          backgroundColor: HexColor('#00D7FF'),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: _isLoading
              ? Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Center(
                    child: new CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(15),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FormBuilderImagePicker(
                          //     decoration: InputDecoration(
                          //       hintText: 'Фото нуждающегося',
                          //     ),
                          //     name: 'photo',
                          //     maxImages: 5,
                          //     key: UniqueKey(),
                          //     bottomSheetPadding: EdgeInsets.all(40)),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
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
                                hintStyle:
                                    new TextStyle(color: Colors.grey[600]),
                                hintText: "ФИО нуждающегося",
                                fillColor: Colors.white),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            decoration:
                                uiInputDecoration(hintText: 'Выберите регион'),
                            hint: Text('Выберите регион'),
                            items: List<DropdownMenuItem>.from(regions
                                    ?.map((region) => DropdownMenuItem(
                                        value: region.id,
                                        child: Text(region.name)))
                                    ?.toList() ??
                                []),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: uiInputDecoration(
                                hintText: 'Адрес нуждающегося'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            maxLines: 5,
                            decoration: uiInputDecoration(
                                hintText: 'Дополнительная информация'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: uiInputDecoration(
                                hintText: '+7 (___) ___-__-__'),
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
        )));
  }

  fetchRegionOptions() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    List<Region> dataRegions = Region.decode(storage.get('regions'));
    setState(() {
      regions = dataRegions;
    });
  }

  requestForm() async {
    var errorMessage = '';
    if (_isLoading) return;
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}

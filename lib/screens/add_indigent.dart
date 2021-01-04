import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/api_manager.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meyirim/models/region.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddIndigentScreen extends StatefulWidget {
  @override
  _AddIndigentScreenState createState() => _AddIndigentScreenState();
}

class _AddIndigentScreenState extends State<AddIndigentScreen> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
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
          title: Text('Добавить нуждающего'),
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
                  child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormBuilderImagePicker(
                              decoration: InputDecoration(
                                hintText: 'Фото',
                              ),
                              name: 'photo',
                              maxImages: 5,
                              key: UniqueKey(),
                              bottomSheetPadding: EdgeInsets.all(40)),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: "fio",
                            key: UniqueKey(),
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
                                hintText: "ФИО нуждающего",
                                fillColor: Colors.white),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: 'Введите ФИО нуждающего'),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderDropdown(
                            name: 'region',
                            key: UniqueKey(),
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
                                fillColor: Colors.white),
                            // initialValue: 'Male',
                            allowClear: true,
                            hint: Text('Город нуждающего'),
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
                          FormBuilderTextField(
                            name: "address",
                            key: UniqueKey(),
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
                                hintText: "Адрес нуждающего",
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: "note",
                            key: UniqueKey(),
                            maxLines: 5,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                    left: 20.0,
                                    right: 20.0),
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
                                hintText: "Дополнительная информация  ",
                                fillColor: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                              name: "phone",
                              key: UniqueKey(),
                              keyboardType: TextInputType.phone,
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
                                  hintText: "+7 (___) ___-__-__",
                                  fillColor: Colors.white),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context,
                                    errorText: 'Введите ваш телефон'),
                                FormBuilderValidators.match(context,
                                    r'^\+7 \(([0-9]{3})\) ([0-9]{3})-([0-9]{2})-([0-9]{2})$',
                                    errorText: 'Неверный номер телефона')
                              ]),
                              inputFormatters: [phoneFormatter]),
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
              ?.toList(),
        };

        for (var i = 0; i < _formKey.currentState.value['photo'].length; i++) {
          if (_formKey.currentState.value != null &&
              _formKey.currentState.value['photo'].length > 0 &&
              _formKey.currentState.value['photo'][i] is File) {
            final mimeTypeData = lookupMimeType(
                _formKey.currentState.value['photo'][i].path,
                headerBytes: [0xFF, 0xD8]).split('/');
            data['photo'][i] = await MultipartFile.fromFile(
                _formKey.currentState.value['photo'][i].path,
                contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
          }
        }

        FormData formData = FormData.fromMap(data);

        await api.postAPICall(url, formData);
        _formKey.currentState?.reset();
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

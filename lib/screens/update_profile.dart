import 'dart:io';
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
import 'package:meyirim/models/region.dart';
import 'package:meyirim/models/user.dart';
import 'package:meyirim/ui/input_decoration.dart';
import 'package:meyirim/ui/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool _isLoading = false;
  bool photoUpdated = false;

  final _formKey = GlobalKey<FormBuilderState>();
  List<Region> regions;

  var phoneFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

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
          title: Text('Редактировать профиль'),
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
                              initialValue: [auth.userData.avatar],
                              decoration: InputDecoration(
                                hintText: 'Фото',
                              ),
                              maxWidth: 258.0,
                              maxHeight: 258.0,
                              name: 'photo',
                              maxImages: 1,
                              key: UniqueKey(),
                              bottomSheetPadding: EdgeInsets.all(40)),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: "name",
                            key: UniqueKey(),
                            initialValue: auth.userData.name,
                            decoration: uiInputDecoration(hintText: 'Имя'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context,
                                  errorText: 'Введите Имя'),
                            ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderDropdown(
                            name: 'region',
                            key: UniqueKey(),
                            initialValue: auth.userData.region?.id,
                            decoration:
                                uiInputDecoration(hintText: 'Регион или город'),
                            allowClear: true,
                            hint: Text('Город или регион'),
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
                              name: "email",
                              key: UniqueKey(),
                              initialValue: auth.userData.email,
                              decoration: uiInputDecoration(hintText: 'E-mail'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.email(context,
                                    errorText: 'Введите E-mail'),
                                FormBuilderValidators.required(context,
                                    errorText: 'Введите E-mail'),
                              ])),
                          SizedBox(
                            height: 20,
                          ),
                          uiButton(onPressed: requestForm, text: 'Сохранить')
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

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() => _isLoading = true);
      var url = globals.updateProfile;
      var api = new APIManager();
      try {
        Map<String, dynamic> data = {
          'name': _formKey.currentState.value['name'],
          'region': _formKey.currentState.value['region'],
          'email': _formKey.currentState.value['email'],
          'photo': Iterable<dynamic>.generate(
                  _formKey.currentState.value['photo'].length)
              .toList(),
        };

        if (_formKey.currentState.value != null &&
            _formKey.currentState.value['photo'].length > 0 &&
            _formKey.currentState.value['photo'][0] is File) {
          final mimeTypeData = lookupMimeType(
              _formKey.currentState.value['photo'][0].path,
              headerBytes: [0xFF, 0xD8]).split('/');
          data['photo'][0] = await MultipartFile.fromFile(
              _formKey.currentState.value['photo'][0].path,
              contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
        }

        FormData formData = FormData.fromMap(data);

        var userData = await api.postAPICall(url, formData);

        auth.userData = User.fromJson(userData);

        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushNamed('Profile');
      } on DioError catch (error) {
        print(error.response.data);
        errorMessage = error.response.data['error']['message'];
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

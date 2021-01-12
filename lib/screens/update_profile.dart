import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool _isLoading = false;
  bool photoUpdated = false;

  final _formKey = GlobalKey<FormState>();
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
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // FormBuilderImagePicker(
                          //     initialValue: [auth.userData.avatar],
                          //     decoration: InputDecoration(
                          //       hintText: 'Фото',
                          //     ),
                          //     maxWidth: 258.0,
                          //     maxHeight: 258.0,
                          //     name: 'photo',
                          //     maxImages: 1,
                          //     key: UniqueKey(),
                          //     bottomSheetPadding: EdgeInsets.all(40)),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            initialValue: auth.userData.firstName,
                            decoration: uiInputDecoration(hintText: 'Имя'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                            key: UniqueKey(),
                            decoration:
                                uiInputDecoration(hintText: 'Регион или город'),
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
                          TextFormField(
                            initialValue: auth.userData.email,
                            decoration: uiInputDecoration(hintText: 'E-mail'),
                          ),
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
  }

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}

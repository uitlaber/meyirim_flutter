import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meyirim/helpers/api_manager.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/globals.dart' as globals;

// ignore: must_be_immutable
class DonateModal extends StatefulWidget {
  int amount = 0;
  final Project project;
  DonateModal({this.amount, this.project});
  @override
  _DonateModalState createState() => _DonateModalState();
}

class _DonateModalState extends State<DonateModal> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;

    return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0))),
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: Wrap(
                        spacing: 10.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(project.fond.avatar),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                project.fond.name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              //@Todo нужно добавить регион
                              Text(
                                project.fond.region?.name ?? 'не указан город',
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    FormBuilder(
                      key: _formKey,
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            // Only numbers can be entered
                            initialValue: '100',
                            attribute: "amount",
                            style: TextStyle(fontSize: 25.0),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 20.0, right: 20.0),
                                border: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(4.0),
                                    ),
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                enabledBorder: new OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(4.0),
                                    ),
                                    borderSide: new BorderSide(
                                        color: Colors.transparent)),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[600]),
                                hintText: "0 ₸",
                                fillColor: HexColor('#F0F0F7')),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.numeric(),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: ButtonTheme(
                                  height: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: RaisedButton(
                                      color: HexColor('#F0F0F7'),
                                      elevation: 0,
                                      child: Text('100₸'),
                                      onPressed: () {
                                        _formKey.currentState.fields['amount']
                                            .currentState
                                            .didChange('100');
                                      }),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 5.0, right: 5.0),
                                  child: ButtonTheme(
                                    height: 50.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                      // side: BorderSide(color: Colors.red)
                                    ),
                                    child: RaisedButton(
                                        color: HexColor('#F0F0F7'),
                                        elevation: 0,
                                        child: Text('500₸'),
                                        onPressed: () {
                                          _formKey.currentState.fields['amount']
                                              .currentState
                                              .didChange('500');
                                        }),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ButtonTheme(
                                  height: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: RaisedButton(
                                      color: HexColor('#F0F0F7'),
                                      elevation: 0,
                                      child: Text('1000₸'),
                                      onPressed: () {
                                        _formKey.currentState.fields['amount']
                                            .currentState
                                            .didChange('1000');
                                      }),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
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
                                color: HexColor('#41BC73'),
                                textColor: Colors.white,
                                onPressed: () => payCard(),
                                elevation: 0,
                                child: Text(
                                  "Оплата банковской картой",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))));
  }

  void payCard() async {
    var errorMessage = '';
    if (_isLoading) return;
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      var url = globals.paymentUrl;
      var api = new APIManager();

      Map<String, String> data = new HashMap();
      data['amount'] =
          _formKey.currentState.fields['amount'].currentState.value;

      return await api.postAPICall(url, data);
    }
  }
}

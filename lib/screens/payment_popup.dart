import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:flutter/services.dart';

final _formKey = GlobalKey<FormBuilderState>();

void displayPaymentForm(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      // Important: Makes content maxHeight = full device height
      context: context,
      builder: (context) {
        // Does not work
        return AnimatedPadding(
            padding: MediaQuery.of(context).viewInsets,
            duration: const Duration(milliseconds: 100),
            curve: Curves.decelerate,
            child: Container(
                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Wrap(
                      children: [
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
                                attribute: "sum",
                                style: TextStyle(fontSize: 25.0),
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: ButtonTheme(
                                      height: 50.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      child: RaisedButton(
                                          color: HexColor('#F0F0F7'),
                                          elevation: 0,
                                          child: Text('100₸'),
                                          onPressed: () {}),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: ButtonTheme(
                                        height: 50.0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          // side: BorderSide(color: Colors.red)
                                        ),
                                        child: RaisedButton(
                                            color: HexColor('#F0F0F7'),
                                            elevation: 0,
                                            child: Text('500₸'),
                                            onPressed: () {}),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: ButtonTheme(
                                      height: 50.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        // side: BorderSide(color: Colors.red)
                                      ),
                                      child: RaisedButton(
                                          color: HexColor('#F0F0F7'),
                                          elevation: 0,
                                          child: Text('1000₸'),
                                          onPressed: () {}),
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
                                    onPressed: () {},
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
      });
}

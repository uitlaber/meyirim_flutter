// Define a custom Form widget.
import 'package:flutter/material.dart';

// final _formKey = GlobalKey<FormState>();

Widget LoginField() {
  return Column(
    children: [
      Text('Логин'),
      TextFormField(
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    ],
  );
}

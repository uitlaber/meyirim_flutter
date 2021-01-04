import 'package:flutter/material.dart';

InputDecoration uiInputDecoration({hintText: ''}) {
  return InputDecoration(
      contentPadding: EdgeInsets.only(left: 20.0, right: 20.0),
      border: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          borderSide: new BorderSide(color: Colors.transparent)),
      enabledBorder: new OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(30.0),
          ),
          borderSide: new BorderSide(color: Colors.transparent)),
      filled: true,
      hintStyle: new TextStyle(color: Colors.grey[600]),
      hintText: hintText,
      fillColor: Colors.white);
}

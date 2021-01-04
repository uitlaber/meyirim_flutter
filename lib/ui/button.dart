import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';

Widget uiButton({VoidCallback onPressed, String text}) {
  return ButtonTheme(
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
        onPressed: onPressed,
        elevation: 0,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

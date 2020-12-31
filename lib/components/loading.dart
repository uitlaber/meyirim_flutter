import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
              ],
            ),
          )
        ],
      ),
    );
  }
}

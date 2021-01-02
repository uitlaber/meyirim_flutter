import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helpers/hex_color.dart';

class SuccessScreen extends StatefulWidget {
  final title;
  final message;

  const SuccessScreen({Key key, this.title, this.message}) : super(key: key);
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#12C06A'),
      appBar: AppBar(
        backgroundColor: HexColor('#12C06A'),
        elevation: 0,
        leading: new Container(
          child: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('Home');
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icon/check-mark.svg',
                width: 100,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                widget.message,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  final message;

  const Message(this.message);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IntrinsicHeight(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Text(widget.message),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

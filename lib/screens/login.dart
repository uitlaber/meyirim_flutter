import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: MediaQuery.of(context).size.height-95,
            decoration: BoxDecoration(
                color: Colors.red
            ),
            child: ElevatedButton(
              child: Text('Регистрация'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.of(context).pushNamed('Register');
              },
            ),
          ),
        ],
      )
    );
  }
}
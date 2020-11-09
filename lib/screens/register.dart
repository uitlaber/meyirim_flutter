import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: MediaQuery.of(context).size.height-95,
            decoration: BoxDecoration(
                color: Colors.orange
            ),
            child:  ElevatedButton(
              child: Text('Главная'),
              onPressed: () {
                // Navigate to the second screen using a named route.
                Navigator.of(context).pushNamed('Home');
              },
            ),
          )
        ],
      ),
    );
  }
}
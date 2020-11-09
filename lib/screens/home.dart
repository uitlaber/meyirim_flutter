import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Войти'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.of(context).pushNamed('Login');
          },
        ),
      ),
    );
  }
}
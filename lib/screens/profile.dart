// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/globals.dart' as globals;
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import '../helpers/hex_color.dart';
//
//
// class Profile extends Widget  {
//   @override
//   Element createElement() {
//     // TODO: implement createElement
//     throw UnimplementedError();
//   }
//
// }

class Profile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  globals.storage.delete(key: 'jwt');
                  Navigator.of(context).pushNamed('Home');
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
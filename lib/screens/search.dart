import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:meyirim/screens/search/result.dart';
import '../app_localizations.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchStatefullWidgetState createState() => _SearchStatefullWidgetState();
}

class _SearchStatefullWidgetState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return SearchResult();
  }
}

// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:meyirim/globals.dart' as globals;
// // import 'package:flutter_form_builder/flutter_form_builder.dart';
// // import '../helpers/hex_color.dart';
// //
// //
// // class Search extends Widget  {
// //   @override
// //   Element createElement() {
// //     // TODO: implement createElement
// //     throw UnimplementedError();
// //   }
// //
// // }
//
// class Search extends StatelessWidget {
//   var userData;
//
//   Search(this.userData);
//
//   @override
//   Widget build(BuildContext context) {
//     print(userData['user']['username']);
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: <Widget>[
//           SliverAppBar(
//             title: Text(userData['user']['username']),
//             actions: <Widget>[
//               IconButton(
//                 icon: Icon(Icons.exit_to_app),
//                 onPressed: () {
//                   globals.storage.delete(key: 'jwt');
//                   Navigator.of(context).pushNamed('Home');
//                 },
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

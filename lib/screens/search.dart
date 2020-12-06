import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'home/lenta.dart';
import '../app_localizations.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchStatefullWidgetState createState() => _SearchStatefullWidgetState();
}

class _SearchStatefullWidgetState extends State<SearchScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: HexColor('#F2F2F7'),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        title: Container(
          height: 36,
          padding:   EdgeInsets.only(left: 10.0,),
          child: TextField(
              decoration: InputDecoration(

                  prefixIcon: Icon(Icons.search, color: HexColor('#00D7FF'),),
                  contentPadding:
                  EdgeInsets.only(left: 20.0, right: 20.0),
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: new BorderSide(
                          color: Colors.transparent)),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: new BorderSide(
                          color: Colors.transparent)),
                  filled: true,
                  hintStyle:
                  new TextStyle(color: Colors.grey[600]),
                  hintText: "Поиск проектов ",
                  fillColor: Colors.white)
          ),
        ),
        backgroundColor: HexColor('#00D7FF'),
        automaticallyImplyLeading: false,

        actions: [
          RawMaterialButton(
            constraints: BoxConstraints.tight(Size(36, 36)),
            onPressed: null,
            child: Icon(Icons.clear, size: 18),
            shape: new CircleBorder(
                side: BorderSide(color: Colors.white)
            ),
            elevation: 0.0,
          ),
        ],
      ),
      body: Container(
        child:  LentaScreen(),
      ),
      bottomNavigationBar: BottomNav(1),
    );
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

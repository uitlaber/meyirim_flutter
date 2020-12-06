import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import '../app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileStatefullWidgetState createState() => _ProfileStatefullWidgetState();
}

class _ProfileStatefullWidgetState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: HexColor('#F2F2F7'),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: HexColor('#00D7FF'),
              padding: EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center ,
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                    child: Icon(Icons.perm_identity_outlined, color: HexColor('#00D7FF'),),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text('Войдите или создайте аккаунт', style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),),
                      Text('Чтобы не терять свои пожертвование ', style: TextStyle(
                        color: Colors.white70
                        ,
                      )),

                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(2),
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
// // class Profile extends Widget  {
// //   @override
// //   Element createElement() {
// //     // TODO: implement createElement
// //     throw UnimplementedError();
// //   }
// //
// // }
//
// class Profile extends StatelessWidget {
//   var userData;
//
//   Profile(this.userData);
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

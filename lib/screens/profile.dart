import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import '../app_localizations.dart';
import 'package:meyirim/globals.dart' as globals;

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (globals.userData == null) {
                        globals.logout();
                        Navigator.of(context).pushNamed('Login');
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: (globals.userData != null &&
                                  globals.userData.avatar != null)
                              ? NetworkImage(globals.userData.avatar.path)
                              : null,
                          child: Icon(
                            Icons.perm_identity_outlined,
                            color: HexColor('#00D7FF'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 283,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (globals.userData != null)
                                    ? globals.userData.name?.isEmpty ?? true
                                        ? 'Аноним'
                                        : globals.userData.name
                                    : 'Войдите или создайте аккаунт',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                  (globals.userData != null)
                                      ? globals.userData.username
                                      : 'Чтобы не терять свои пожертвование ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  (globals.userData != null)
                      ? IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () => displayBottomSheet(context))
                      : Container()
                ],
              ),
            ),

            // FutureBuilder<String>(
            //   future: globals.user_code,
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Text(snapshot.data);
            //     }

            //     return Text('112');
            //   },
            // )
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(2),
    );
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
                child: ListView(
              children: [
                ListTile(
                  title: Text('Выход'),
                  onTap: () {
                    globals.logout();
                    Navigator.of(context).pushNamed('Login');
                  },
                ),
                ListTile(
                  title: Text('Код'),
                  onTap: () async {
                    var code = await globals.userCode();
                    print(code);
                  },
                ),
              ],
            )),
          );
        });
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

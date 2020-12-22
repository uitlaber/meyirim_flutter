import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/components/bottom_nav.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/auth.dart' as auth;
import 'profile/donations.dart';
import 'package:meyirim/components/profile_button.dart';

class ProfileScreen extends StatefulWidget {
  @override
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileStatefullWidgetState createState() => _ProfileStatefullWidgetState();
}

class _ProfileStatefullWidgetState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                      if (auth.userData == null) {
                        auth.logout();
                        Navigator.of(context).pushNamed('Login');
                      }
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: (auth.userData != null &&
                                  auth.userData.avatar != null)
                              ? NetworkImage(auth.userData.avatar)
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (auth.userData != null)
                                    ? auth.userData.name?.isEmpty ?? true
                                        ? 'Аноним'
                                        : auth.userData.name
                                    : 'Войдите или создайте аккаунт',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              Text(
                                  (auth.userData != null)
                                      ? auth.userData.username
                                      : 'Чтобы не терять свои пожертвование ',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  (auth.userData != null)
                      ? IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () => displayBottomSheet(context))
                      : Container()
                ],
              ),
            ),
            Donations(),
            InkWell(
              child: ProfileButton(
                icon: Icons.add_circle,
                label: 'Добавить нуждающегося',
                color: HexColor('#00D7FF'),
              ),
            ),
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
                  title: Text('Редактировать профиль'),
                  onTap: () {
                    auth.logout();
                    Navigator.of(context).pushNamed('Login');
                  },
                ),
                ListTile(
                  title: Text('Выход'),
                  onTap: () {
                    auth.logout();
                    Navigator.of(context).pushNamed('Login');
                  },
                ),
              ],
            )),
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class BottomNav extends StatefulWidget {
  int _page;
  BottomNav(this._page);

  @override
  State<StatefulWidget> createState() {
    return BottomNavState();
  }
}

class BottomNavState extends State<BottomNav> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  void _onItemTapped(int index) {
    setState(() {
      widget._page = index;
    });

    switch (widget._page) {
      case 0:
        {
          Navigator.of(context).pushNamed('Home');
        }
        break;
      case 1:
        {
          Navigator.of(context).pushNamed('Search');
        }
        break;
      case 2:
        {
          Navigator.of(context).pushNamed('Profile');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/home.svg',
              color: widget._page == 0
                  ? HexColor('#00D7FF')
                  : HexColor('#A5A5A5')),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/search.svg',
              color: widget._page == 1
                  ? HexColor('#00D7FF')
                  : HexColor('#A5A5A5')),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/user.svg',
              color: widget._page == 2
                  ? HexColor('#00D7FF')
                  : HexColor('#A5A5A5')),
          label: '',
        ),
      ],
      currentIndex: widget._page,
      selectedItemColor: Colors.amber[800],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
    return CurvedNavigationBar(
      height: 50.0,
      // buttonBackgroundColor: Colors.red,
      key: _bottomNavigationKey,
      backgroundColor: Colors.transparent,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      color: Colors.white,
      index: widget._page,

      items: [
        SvgPicture.asset('assets/icon/home.svg',
            color:
                widget._page == 0 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
        SvgPicture.asset('assets/icon/search.svg',
            color:
                widget._page == 1 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
        SvgPicture.asset('assets/icon/user.svg',
            color:
                widget._page == 2 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
      ],
      onTap: _onItemTapped,
    );
  }
}

import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const ProfileButton({Key key, this.label, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Row(children: [
          Icon(icon, color: color, size: 44),
          SizedBox(
            width: 10,
          ),
          Text(label, style: TextStyle(color: color, fontSize: 15)),
        ]));
  }
}

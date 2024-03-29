import 'package:flutter/material.dart';
import 'package:meyirim/models/user.dart';
import 'package:meyirim/helpers/hex_color.dart';

class FondCard extends StatelessWidget {
  final User fond;

  const FondCard({Key key, this.fond}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Fond/${fond.id}'),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(fond.avatar),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fond.name,
                // style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(fond.region?.name ?? 'не указан город',
                  style: TextStyle(color: HexColor('#8C8C8C'), fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

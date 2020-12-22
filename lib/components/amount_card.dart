import 'package:flutter/material.dart';
import 'package:meyirim/globals.dart' as globals;

// ignore: must_be_immutable
class AmountCount extends StatefulWidget {
  String label;
  Color labelColor;
  int amount;

  AmountCount({Key key, this.label, this.labelColor, this.amount})
      : super(key: key);

  @override
  _AmountCountState createState() => _AmountCountState();
}

class _AmountCountState extends State<AmountCount> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, right: 15, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: widget.labelColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(globals.formatCur(widget.amount),
                      style: TextStyle(
                          fontSize: 21.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            // Container(width: 30, height: 100, color: Colors.red)
            Container(
              width: 21,
              padding: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                  color: widget.labelColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )),
              child: Icon(Icons.arrow_right, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

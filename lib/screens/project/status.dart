import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/screens/payment_popup.dart';
import 'package:meyirim/globals.dart';

// ignore: must_be_immutable
class ProjectStatus extends StatefulWidget {
  Project project;
  bool full = false;
  ProjectStatus({Key key, this.project, this.full}) : super(key: key);
  @override
  _ProjectStatusState createState() => _ProjectStatusState();
}

class _ProjectStatusState extends State<ProjectStatus> {
  @override
  Widget build(BuildContext context) {
    String routeName = ModalRoute.of(context).settings.name;
    print(routeName);
    return Padding(
      padding:
          EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.project.isFinished != 1 ||
              widget.project.isFinished == 1 &&
                  routeName.startsWith('Project/'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('НУЖНО',
                    style: TextStyle(color: HexColor('#B2B3B2'), fontSize: 10)),
                Text(
                  formatCur(widget.project.requiredAmount),
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('СОБРАЛИ',
                  style: TextStyle(color: HexColor('#B2B3B2'), fontSize: 10)),
              Text(
                formatCur(widget.project.collectedAmount),
                style: TextStyle(
                  color: HexColor('#00D7FF'),
                  fontSize: 20.0,
                ),
              )
            ],
          ),
          if (widget.project.isFinished == 1 ||
              routeName.startsWith('Project/'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('УЧАСТВОВАЛИ',
                    style: TextStyle(color: HexColor('#B2B3B2'), fontSize: 10)),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '0',
                      // widget.project.donationsCount != null
                      //     ? formatNum(widget.project.donationsCount.toDouble())
                      //     : '0',
                      style: TextStyle(
                        color: HexColor('#41BC73'),
                        fontSize: 20.0,
                      ),
                    ),
                    Icon(
                      Icons.people_alt_outlined,
                      color: HexColor('#41BC73'),
                      size: 25,
                    )
                  ],
                )
              ],
            ),
          if (widget.project.isFinished != 1 &&
              !routeName.startsWith('Project/'))
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RaisedButton(
                  color: HexColor('#41BC73'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  textColor: Colors.white,
                  onPressed: () {
                    displayPaymentForm(context, widget.project);
                  },
                  elevation: 0,
                  child: Text(
                    "Помочь",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          if (widget.project.isFinished == 1 &&
              !routeName.startsWith('Project/'))
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('Завершен',
                    style: TextStyle(
                        color: HexColor('#41BC73'),
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.check_circle,
                  color: HexColor('#41BC73'),
                )
              ],
            )
        ],
      ),
    );
  }
}

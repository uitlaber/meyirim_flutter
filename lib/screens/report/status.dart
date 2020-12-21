import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/globals.dart';

// ignore: must_be_immutable
class ReportStatus extends StatefulWidget {
  Project project;
  bool full = false;
  ReportStatus({Key key, this.project, this.full}) : super(key: key);
  @override
  _ReportStatusState createState() => _ReportStatusState();
}

class _ReportStatusState extends State<ReportStatus> {
  @override
  Widget build(BuildContext context) {
    String routeName = ModalRoute.of(context).settings.name;
    return Padding(
      padding:
          EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.project.isFinished != 1 ||
              widget.project.isFinished == 1 && routeName == 'Project')
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('УЧАСТВОВАЛИ',
                  style: TextStyle(color: HexColor('#B2B3B2'), fontSize: 10)),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    formatNum(widget.project.donations.length),
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
        ],
      ),
    );
  }
}

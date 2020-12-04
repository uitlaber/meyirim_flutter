import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import '../payment_popup.dart';
import 'package:flutter_share/flutter_share.dart';

class LentaScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LentaScreenState();
  }
}

class LentaScreenState extends State<LentaScreen> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  Widget build(BuildContext context) {
    List<CharityModel> charityList = new List();

    for (int i = 0; i < 10; i++) {
      charityList.add(new CharityModel(
          i.toString(),
          "Нужно помочь Айдару",
          "Testing",
          "55000",
          "45069",
          "http://picsum.photos/id/90" + i.toString() + "/500/700",
          "Добряки Шымкента"));
    }

    return Container(
        child: ListView.builder(
      itemCount: charityList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(charityList[index].photo)),
                        gradient: new LinearGradient(
                          end: const Alignment(0.0, 5.0),
                          begin: const Alignment(0.0, 5.0),
                          colors: <Color>[
                            const Color(0x8A000000),
                            Colors.black12.withOpacity(0.0)
                          ],
                        ),
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                              end: const Alignment(0.0, -1),
                              begin: const Alignment(0.0, 1),
                              colors: <Color>[
                                const Color(0x8A000000),
                                Colors.black12.withOpacity(0.0)
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black12.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,

                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.people, color: Colors.white),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '254',
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Text(charityList[index].title,
                                    style: TextStyle(
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.white)),
                              ],
                            ),
                          ))),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('НУЖНО',
                                style: TextStyle(
                                    color: HexColor('#B2B3B2'), fontSize: 10)),
                            Text(
                              charityList[index].needSum + '₸',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20.0,
                              ),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('СОБРАЛИ',
                                style: TextStyle(
                                    color: HexColor('#B2B3B2'), fontSize: 10)),
                            Text(
                              charityList[index].collectedSum + '₸',
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
                            RaisedButton(
                              color: HexColor('#41BC73'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                // side: BorderSide(color: Colors.red)
                              ),
                              textColor: Colors.white,
                              onPressed: () {
                                displayPaymentForm(context);
                              },
                              elevation: 0,
                              child: Text(
                                "Помочь",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Divider(color: Colors.black12),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.brown.shade800,
                                child: Text('ДШ'),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  charityList[index].fond,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Шымкент',
                                    style: TextStyle(
                                        color: HexColor('#8C8C8C'),
                                        fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                        IconButton(icon: Icon(Icons.share), onPressed: share),
                      ],
                    ),
                  )
                ],
              )),
        );
      },
    ));
  }
}

class CharityModel {
  CharityModel(
    this.id,
    this.title,
    this.text,
    this.needSum,
    this.collectedSum,
    this.photo,
    this.fond,
  );

  var id = "";
  var title = "";
  var text = "";
  var needSum = "";
  var collectedSum = "";
  var photo = "";
  var fond = "";
}

import 'package:flutter/material.dart';
import 'package:meyirim/screens/report/status.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReportCard extends StatefulWidget {
  final Report report;

  const ReportCard(this.report);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportCard> {
  @override
  Widget build(BuildContext context) {
    Report report = widget.report;

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
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, 'Report/${report.id}');
                  },
                  child: Stack(
                    // fit: StackFit.loose,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        child: AspectRatio(
                          aspectRatio: 3 / 2,
                          child: Hero(
                            tag: report.firstPhotoUrl,
                            child: CachedNetworkImage(
                              imageUrl: report.firstPhotoUrl,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned.fill(
                          child: Container(
                        decoration: BoxDecoration(
                          gradient: new LinearGradient(
                            end: const Alignment(0.0, -1),
                            begin: const Alignment(0.0, 0.6),
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
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        top: 5.0,
                                        bottom: 5.0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        color: Colors.black.withOpacity(0.5)),
                                    child: Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo_camera,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          report.photos.length.toString(),
                                          style: TextStyle(color: Colors.white),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Text(report.title,
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                      ))
                    ],
                  )),
              //Статус проекта
              ReportStatus(project: report.project),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Divider(color: Colors.black12),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.brown.shade800,
                            backgroundImage:
                                NetworkImage(report.fond.getAvatar),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.fond.title,
                            ),
                            Text(report.fond.regionId ?? 'не указан город',
                                style: TextStyle(
                                    color: HexColor('#8C8C8C'), fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () => shareReport(report)),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

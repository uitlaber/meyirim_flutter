import 'package:flutter/material.dart';
import 'package:meyirim/models/report.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:meyirim/helpers/youtube.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meyirim/screens/report/status.dart';

class ReportInfo extends StatefulWidget {
  Report report;
  int _current = 0;

  ReportInfo(this.report);

  @override
  _ReportInfoState createState() => _ReportInfoState();
}

class _ReportInfoState extends State<ReportInfo> {
  @override
  Widget build(BuildContext context) {
    Report report = widget.report;
    int sliderLength = report.photos.length;
    YoutubePlayerController _controller;

    String videUrl = getIdFromUrl(report.videoUrl);

    if (videUrl.isNotEmpty) {
      // ignore: close_sinks
      _controller = YoutubePlayerController(
        initialVideoId: getIdFromUrl(report.videoUrl),
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
      sliderLength = sliderLength + 1;
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned(
                      child: CarouselSlider.builder(
                        itemCount: sliderLength,
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: 300,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                widget._current = index;
                              });
                            }),
                        itemBuilder: (context, index) {
                          if (report.photos.asMap().containsKey(index)) {
                            return Container(
                                child: Hero(
                                    tag: report.photos[index].path,
                                    child: CachedNetworkImage(
                                      height: 250,
                                      imageUrl: report.photos[0].path,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            alignment: Alignment.topCenter,
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Center(
                                        child: Icon(Icons.error),
                                      ),
                                    )));
                          } else {
                            return Container(
                              child: YoutubePlayerIFrame(
                                controller: _controller,
                                aspectRatio: 16 / 9,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    if (sliderLength > 1)
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: List<int>.generate(sliderLength, (i) => i)
                                .map((index) {
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget._current == index
                                      ? HexColor('#00D7FF')
                                      : Colors.white,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                  ],
                ),
                ReportStatus(project: report.project),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(color: Colors.black12),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    report.description,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: HexColor('#EEEEEE'),
        height: 72,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 100,
              ),
              Container(
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.share, color: HexColor('#A5A5A5')),
                    onPressed: () {
                      shareReport(report);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //
      //   items:  <BottomNavigationBarItem>[
      //     project.isFinished != 1?
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.favorite),
      //       label: 'Помочь',
      //     ):BottomNavigationBarItem(
      //       icon: Icon(Icons.insert_drive_file_outlined),
      //       label: 'Отчет',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.share),
      //       label: 'Поделиться',
      //     ),
      //   ],
      //   currentIndex: 0,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white,
      //   backgroundColor: HexColor('#41BC73'),
      //
      //   onTap: _onItemTapped,
      // ),
    );
  }
}

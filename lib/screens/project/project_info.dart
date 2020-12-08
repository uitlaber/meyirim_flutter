import 'package:flutter/material.dart';
import 'package:meyirim/models/project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart';
import 'package:meyirim/screens/payment_popup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meyirim/components/project_status.dart';

class ProjectInfo extends StatefulWidget {
  Project project;
  int _current = 0;

  ProjectInfo(this.project);

  @override
  _ProjectInfoState createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;

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
                        itemCount: project.photos.length,
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            height: 400,
                            onPageChanged: (index, reason) {
                              setState(() {
                                widget._current = index;
                              });
                            }),
                        itemBuilder: (context, index) {
                          return Container(
                              child: Hero(
                            tag: project.photos[index].path,
                            child: CachedNetworkImage(
                              imageUrl: project.photos[0].path,
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
                              errorWidget: (context, url, error) => Center(
                                child: Icon(Icons.error),
                              ),
                            ),
                          ));
                        },
                      ),
                    ),
                    if (project.photos.length > 1)
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: project.photos.map((photo) {
                              int _index = project.photos.indexOf(photo);
                              return Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget._current == _index
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
                ProjectStatus(project: project)
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
                    project.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    project.description,
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
        height: 72,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 80,
              ),
              Container(
                width: 204,
                child: SizedBox(
                  width: double.infinity,
                  child: (project.isFinished != 1)
                      ? RaisedButton(
                          color: HexColor('#41BC73'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            // side: BorderSide(color: Colors.red)
                          ),
                          textColor: Colors.white,
                          onPressed: () {
                            displayPaymentForm(context, project);
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
                        )
                      : Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text('Завершен',
                                style: TextStyle(
                                    color: HexColor('#41BC73'),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16)),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.check_circle,
                              color: HexColor('#41BC73'),
                            )
                          ],
                        ),
                ),
              ),
              Container(
                  width: 80,
                  child: IconButton(
                    icon: Icon(Icons.share, color: HexColor('#A5A5A5')),
                    onPressed: () {
                      shareProject(project);
                    },
                  ))
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
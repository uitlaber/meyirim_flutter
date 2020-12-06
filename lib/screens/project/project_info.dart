import 'package:flutter/material.dart';
import 'package:meyirim/models/project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/globals.dart';
import 'package:meyirim/screens/payment_popup.dart';

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

    void _onItemTapped(int index) {

      switch(index) {
        case 0: {
          if (project.isFinished != 1) {
            displayPaymentForm(context, project);
          }else{
            //@Todo Редирект на отчет
            print(project.id);
          }
        }
        break;

        case 1: {
          shareProject(project);
        }
        break;
      }


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
                        itemCount: project.photos.length,
                        options: CarouselOptions(
                            enableInfiniteScroll: false,
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                widget._current = index;
                              });
                            }),
                        itemBuilder: (context, index) {
                          return Container(
                              child: Hero(
                                tag: project.photos[index].path,
                                child: Image.network(
                                  project.photos[index].path,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ));
                        },
                      ),
                    ),
                    if(project.photos.length > 1)
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
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (project.isFinished != 1)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('НУЖНО',
                                style: TextStyle(
                                    color: HexColor('#B2B3B2'), fontSize: 10)),
                            Text(
                              project.requiredAmount.round().toString() + '₸',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 24.0,
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
                            project.collectedAmount.round().toString() + '₸',
                            style: TextStyle(
                              color: HexColor('#00D7FF'),
                              fontSize: 24.0,
                            ),
                          )
                        ],
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('УЧАСТВОВАЛИ',
                              style: TextStyle(
                                  color: HexColor('#B2B3B2'), fontSize: 10)),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                project.donations.length.toString(),
                                style: TextStyle(
                                  color: HexColor('#41BC73'),
                                  fontSize: 24.0,
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
                      if (project.isFinished == 1)
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
                ),
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

      bottomNavigationBar: BottomNavigationBar(

        items:  <BottomNavigationBarItem>[
          project.isFinished != 1?
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Помочь',
          ):BottomNavigationBarItem(
            icon: Icon(Icons.insert_drive_file_outlined),
            label: 'Отчет',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.share),
            label: 'Поделиться',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: HexColor('#41BC73'),

        onTap: _onItemTapped,
      ),
    );
  }
}

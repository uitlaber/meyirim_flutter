import 'package:flutter/material.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/helpers/hex_color.dart';
import '../payment_popup.dart';
import 'package:meyirim/globals.dart';
import 'package:carousel_slider/carousel_slider.dart';


class ProjectCard extends StatefulWidget {
  final Project project;
  const ProjectCard(this.project);
  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    Project project = widget.project;
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
                  Navigator.pushNamed(context, 'Project', arguments: {'id':project.id});
                },
                child:  Stack(
                  // fit: StackFit.loose,
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(  topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))
                    ),
                      child: Hero(
                        tag: project.photos[0].path,
                        child: Image.network(
                          project.photos[0].path,
                          fit: BoxFit.cover,
                          width: double.infinity,
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
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0 ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.black.withOpacity(0.5)
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,

                                        children: [
                                          Icon(Icons.people_alt_outlined, color: Colors.white, size: 15,),
                                          SizedBox(width: 5,),
                                          Text(project.donations.length.toString(), style: TextStyle(
                                              color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0 ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.black.withOpacity(0.5)
                                      ),
                                      child: Wrap(
                                        crossAxisAlignment: WrapCrossAlignment.center,

                                        children: [
                                          Icon(Icons.photo_camera, color: Colors.white, size: 15,),
                                          SizedBox(width: 5,),
                                          Text(project.photos.length.toString(), style: TextStyle(
                                              color: Colors.white
                                          ),)
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Text(project.title,
                                    style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        )
                    )
                  ],
                )
              ),
              Padding(
                padding:
                EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    if(project.isFinished != 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('НУЖНО', style: TextStyle( color: HexColor('#B2B3B2'), fontSize: 10)),
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
                    if(project.isFinished != 1)
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
                          ),
                        ],
                      ),
                    if(project.isFinished == 1)
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Завершен', style: TextStyle( color: HexColor('#41BC73'), fontWeight: FontWeight.bold)),
                          SizedBox(width: 5,),
                          Icon(Icons.check_circle, color: HexColor('#41BC73'),)
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
                            backgroundImage: NetworkImage(project.fond.avatar.path),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              project.fond.name,
                              // style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(project.fond.region.name,
                                style: TextStyle(
                                    color: HexColor('#8C8C8C'),
                                    fontSize: 12)),
                          ],
                        )
                      ],
                    ),
                    IconButton(icon: Icon(Icons.share), onPressed: () => shareProject(project) ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}


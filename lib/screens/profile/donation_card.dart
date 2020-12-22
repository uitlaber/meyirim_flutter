import 'package:flutter/material.dart';
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/donation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/helpers/hex_color.dart';

class DonationCard extends StatefulWidget {
  Project project;
  Donation donation;
  bool isReferal = false;
  DonationCard({Key key, this.project, this.donation, this.isReferal})
      : super(key: key);

  @override
  _DonationCardState createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  @override
  Widget build(BuildContext context) {
    var project = widget.project;
    var donation = widget.donation;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, 'Project',
          arguments: {'id': project.id}),
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(21)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              color: Colors.red,
              width: 124,
              height: 94,
              imageUrl: project.firstPhotoUrl,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(19)),
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isReferal ? 'Вы привлекли  ' : 'Вы помогли',
                    style: TextStyle(
                      color: widget.isReferal
                          ? HexColor('#F82E55')
                          : HexColor('#41BC73'),
                      fontSize: 15,
                    ),
                  ),
                  Text(globals.formatCur(donation.amount),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, bottom: 8.0),
                    child: Text(globals.formatDate(donation.paidAt),
                        style: TextStyle(
                            color: HexColor('#DBDBDB'), fontSize: 11)),
                  ),
                  Text(project.fond.name,
                      style:
                          TextStyle(color: HexColor('#3B3B3B'), fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

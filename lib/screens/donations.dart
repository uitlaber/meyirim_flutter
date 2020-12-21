import 'package:flutter/material.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/helpers/hex_color.dart';

class DonationsScreen extends StatefulWidget {
  final bool isReferal;

  DonationsScreen({Key key, this.isReferal}) : super(key: key);

  @override
  _DonationsScreenState createState() => _DonationsScreenState();
}

class _DonationsScreenState extends State<DonationsScreen> {
  ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  int _maxPage = 2;
  bool _isLoading = false;
  bool _hasError = false;

  List<Donation> donations = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#F2F2F7'),
      appBar: AppBar(
        backgroundColor: HexColor('#00D7FF'),
      ),
      body: FutureBuilder<List<Donation>>(
        future: fetchDonations(page: _currentPage, isRef: widget.isReferal),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Row(
                    children: [Text('111')],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // print(snapshot.error);
            return Container(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return Center(
              child: new CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
            );
          }
        },
      ),
    );
  }
}

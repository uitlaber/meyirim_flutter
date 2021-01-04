import 'package:flutter/material.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/project.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:meyirim/globals.dart' as globals;
import 'profile/donation_card.dart';

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
  void initState() {
    loadMore();
    _scrollController
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#F2F2F7'),
        appBar: AppBar(
            title: Text(
                widget.isReferal ? 'Через меня помогли ' : 'Мои пожертвования'),
            backgroundColor: HexColor('#00D7FF'),
            elevation: 0),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_isLoading)
                Expanded(
                  child: Center(
                    child: new CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))),
                  ),
                ),
              SizedBox(height: 15),
              Expanded(
                child: createListView(context),
              ),
            ],
          ),
        ));
  }

  Widget createListView(BuildContext context) {
    if (_hasError) {
      return Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.grey,
            size: 44,
          ),
          Text(
            'Ошибка при загрузке,\nпожалуйста проверьте интернет',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ));
    }
    return (donations.length > 0)
        ? ListView.builder(
            controller: _scrollController,
            itemCount: donations.length,
            itemBuilder: (BuildContext context, int index) {
              Donation donation = donations[index];
              Project project = donation.project;
              if (_hasError) {
                return Text('ERROR');
              }
              return DonationCard(
                  donation: donation,
                  project: project,
                  isReferal: widget.isReferal);
            },
          )
        : !_isLoading
            ? Center(
                child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 5,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.grey,
                    size: 44,
                  ),
                  Text(
                    'Список пуст',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ))
            : Container();
  }

  void loadMore() async {
    if (!_isLoading && _maxPage > _currentPage) {
      setState(() => _isLoading = true);
      try {
        var result =
            await fetchDonations(page: _currentPage, isRef: widget.isReferal);

        List<Donation> newDonations = List<Donation>.from(
            result['data'].map((x) => Donation.fromJson(x)));

        setState(() {
          _currentPage++;
          _maxPage = result['meta']['pagination']['total_pages'] + 1;
          donations.addAll(newDonations);
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }
}

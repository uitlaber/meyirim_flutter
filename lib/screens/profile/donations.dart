import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/globals.dart' as globals;
import 'package:meyirim/models/donation_amount.dart';
import 'package:meyirim/components/amount_card.dart';

class Donations extends StatefulWidget {
  @override
  _DonationsState createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<DonationAmount>(
          future: fetchDonationAmounts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(children: [
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('Donations');
                  },
                  child: AmountCount(
                      label: 'Мои пожертвование',
                      labelColor: HexColor('#41BC73'),
                      amount: snapshot.data.amount),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('Referals');
                  },
                  child: AmountCount(
                      label: 'Помогли через меня',
                      labelColor: HexColor('#FF2D55'),
                      amount: snapshot.data.referal),
                ),
              ]);
            } else if (snapshot.hasError) {
              return Container(
                margin: EdgeInsets.all(15),
                child: Text('Не удалось загрузить ваши пожертвование'),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(15),
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ],
    );
  }
}

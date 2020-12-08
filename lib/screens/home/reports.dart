import 'package:flutter/material.dart';
import 'package:meyirim/helpers/hex_color.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/screens/report/card.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchReports(),
        builder: (BuildContext context, AsyncSnapshot<List<Report>> snapshot) {
        print(snapshot.error);
          if (snapshot.hasData){
            var reports = snapshot.data;

            return Container(
                child: ListView.builder(
                  itemCount: reports.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ReportCard(reports[index]);
                  },
                )
            );
          }else if(snapshot.hasError){
            return Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  children: [
                    Icon(Icons.error_outline, color: Colors.grey, size: 44,),
                    Text('Ошибка при загрузке,\nпожалуйста проверьте интернет', style: TextStyle(color: Colors.grey),),
                  ],
                )
            );
          }else{
            return Center(
              child: new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(HexColor('#00D7FF'))
              ),
            );
          }
        }
    );
  }
}

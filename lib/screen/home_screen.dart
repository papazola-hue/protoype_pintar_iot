import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/credit_screen.dart';
import 'package:protoype_pintar_iot/screen/history_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_card_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class DataStatistik {
  final String title;
  final String kelembapan;
  final charts.Color color;

  DataStatistik(this.title, this.kelembapan, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<dynamic, dynamic>> lists = [];
  List<DataStatistik> data = [];

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  Widget build(BuildContext cozntext) {
    return ScaffoldWidget(
      title: "Dashboard",
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TemplateCardWidget(
              title: 'History',
              widget: Icon(FontAwesomeIcons.history),
              fn: () {
                Nav.push(context, HistoryScreen());
              },
            ),
            TemplateCardWidget(
              title: 'Credit',
              widget: Icon(FontAwesomeIcons.userAlt),
              fn: () {
                Nav.push(context, CreditScreen());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TemplateTextWidget(
              title: "Statistik",
              size: 24,
              fontWeight: FontWeight.bold,
              warna: Colors.grey,
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder(
                future: dbRef.once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  // try {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (snapshot.hasError) {
                    return Container(
                        child: Center(
                            child: TemplateTextWidget(
                      title: "Terjadi Kesalahan",
                    )));
                  }
                  if (snapshot.hasData) {
                    lists.clear();
                    data.clear();
                    Map<dynamic, dynamic> values = snapshot.data.value;
                    values.forEach((key, values) {
                      // lists.add(values);
                      data.add(DataStatistik(values['Id'].toString(),
                          values["Kelembapan"].toString(), Colors.red));
                    });
                    //  var data;
                    //  for(var i = 0;i < lists.length ;i++){
                    //    data = [
                    //     DataStatistik(lists[i]['Id'], lists[i]["Suhu"], Colors.red),
                    //   ];
                    // }
                    var series = [
                      charts.Series(
                        domainFn: (DataStatistik dataStatistik, _) =>
                            dataStatistik.title,
                        measureFn: (DataStatistik dataStatistik, _) =>
                            int.parse(dataStatistik.kelembapan),
                        colorFn: (DataStatistik dataStatistik, _) =>
                            dataStatistik.color,
                        id: 'Clicks',
                        data: data,
                      ),
                    ];
                    var chart = charts.BarChart(
                      series,
                      animate: true,
                    );

                    var chartWidget = Padding(
                      padding: EdgeInsets.all(32.0),
                      child: SizedBox(
                        height: 200.0,
                        child: chart,
                      ),
                    );
                    return Container(
                      child: chartWidget,
                    );
                  } else {
                    return Container(
                        child: Center(
                            child: TemplateTextWidget(
                      title: "Data Kosong",
                    )));
                  }
                  // } catch (e) {
                  //   print(e);
                  //   return Container(
                  //       child: Center(
                  //           child: TemplateTextWidget(
                  //     title: "Periksa Koneksi dan Ulangi Aplikasi",
                  //   )));
                  // }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

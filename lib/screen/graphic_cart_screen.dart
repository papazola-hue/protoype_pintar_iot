import 'package:charts_flutter/flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_pintar_iot/screen/home_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/src/painting/basic_types.dart' as axis;

class GraphicCardScreen extends StatefulWidget {
  const GraphicCardScreen({Key key, this.id}) : super(key: key);
  final String id;

  @override
  _GraphicCardScreenState createState() => _GraphicCardScreenState();
}

class _GraphicCardScreenState extends State<GraphicCardScreen> {
  List<Map<dynamic, dynamic>> lists = [];
  List<DataStatistik> data1 = [];
  List<DataStatistik> data2 = [];
  List<DataStatistik> data3 = [];

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScaffoldWidget(
      title: "Chart Alat ${widget.id}",
      child: Center(
        child: Container(
          height: size.height * 0.7,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 16, right: 16, top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 10,
                ),
                TemplateTextWidget(
                  title: "Statistik ${widget.id}",
                  size: 24,
                  fontWeight: FontWeight.bold,
                  warna: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  width: size.width * 0.9,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TemplateTextWidget(
                        title: "Merah : Kelembapan",
                        warna: Colors.white,
                      ),
                      TemplateTextWidget(
                        title: "Biru : Ketinggian",
                        warna: Colors.white,
                      ),
                      TemplateTextWidget(
                        title: "Hijau : Suhu",
                        warna: Colors.white,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                FutureBuilder(
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
                      data1.clear();
                      data2.clear();
                      data3.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      values.forEach((key, values) {
                        // lists.add(values);
                        if (values['Id'] == widget.id) {
                          data1.add(DataStatistik(
                              values['Waktu'].toString(),
                              values["Kelembapan"].toString(),
                              Colors.red,
                              values['Tanggal'].toString()));
                          data2.add(DataStatistik(
                              values['Waktu'].toString(),
                              values["Ketinggian"].toString(),
                              Colors.blue,
                              values['Tanggal'].toString()));
                          data3.add(DataStatistik(
                              values['Waktu'].toString(),
                              values["Suhu"].toString(),
                              Colors.green,
                              values['Tanggal'].toString()));
                        }
                      });
                      var series = [
                        charts.Series(
                            domainFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.title,
                            measureFn: (DataStatistik dataStatistik, _) =>
                                int.parse(dataStatistik.kelembapan),
                            colorFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.color,
                            id: 'Clicks',
                            data: data1,
                            labelAccessorFn: (DataStatistik dataStatistik, _) =>
                                '${dataStatistik.kelembapan.toString()}'),
                        charts.Series(
                            domainFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.title,
                            measureFn: (DataStatistik dataStatistik, _) =>
                                int.parse(dataStatistik.kelembapan),
                            colorFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.color,
                            id: 'Clicks',
                            data: data2,
                            labelAccessorFn: (DataStatistik dataStatistik, _) =>
                                '${dataStatistik.kelembapan.toString()}'),
                        charts.Series(
                            domainFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.title,
                            measureFn: (DataStatistik dataStatistik, _) =>
                                int.parse(dataStatistik.kelembapan),
                            colorFn: (DataStatistik dataStatistik, _) =>
                                dataStatistik.color,
                            id: 'Clicks',
                            data: data3,
                            labelAccessorFn: (DataStatistik dataStatistik, _) =>
                                '${dataStatistik.kelembapan.toString()}'),
                      ];
                      var chart = charts.BarChart(series,
                          animate: false,
                          // barGroupingType: charts.BarGroupingType.grouped,
                          // defaultRenderer: charts.BarRendererConfig(
                          //   groupingType: charts.BarGroupingType.grouped,
                          //   strokeWidthPx: 1.0,
                          // ),
                          barRendererDecorator:
                              new charts.BarLabelDecorator<String>(),
                          domainAxis: new charts.OrdinalAxisSpec(),
                          // selectionModels: [
                          //   charts.SelectionModelConfig(
                          //       changedListener: (charts.SelectionModel model) {
                          //     if (model.hasDatumSelection)
                          //       print(model.selectedSeries[0].data);
                          //   })
                          // ]
                      );

                      return SingleChildScrollView(
                          scrollDirection: axis.Axis.horizontal,
                          child: Container(
                              width: 800,
                              height: 200,
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: chart),
                                ],
                              )));
                    } else {
                      return Container(
                          child: Center(
                              child: TemplateTextWidget(
                        title: "Data Kosong",
                      )));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

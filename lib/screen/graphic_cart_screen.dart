import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/screen/home_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Chart Alat ${widget.id}",
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
                  Map<dynamic, dynamic> values = snapshot.data.value;
                  values.forEach((key, values) {
                    // lists.add(values);
                    if (values['Id'] == widget.id) {
                      data1.add(DataStatistik(values['Waktu'].toString(),
                          values["Kelembapan"].toString(), Colors.red));
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
              },
            ),
          ],
        ),
      ),
    );
  }
}

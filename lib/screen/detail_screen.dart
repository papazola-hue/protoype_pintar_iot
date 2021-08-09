import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/maps_screen.dart';
import 'package:protoype_pintar_iot/widget/button_widget_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/stack_detail_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key key, this.nama, this.data}) : super(key: key);
  final String nama;
  final Map<dynamic, dynamic> data;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Map<dynamic, dynamic>> lists = [];
  Map<dynamic, dynamic> data = {};

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Detail " + widget.nama,
      child: FutureBuilder(
        future: dbRef.once(),
        builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(child: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.hasError) {
            return Container(
                child: Center(
                    child: TemplateTextWidget(
              title: "Periksa Koneksi dan Ulangi Aplikasi",
            )));
          }
          if (snapshot.hasData) {
            lists.clear();

            Map<dynamic, dynamic> values = snapshot.data.value;
            values.forEach((key, values) {
              lists.add(values);
            });
            data = lists.firstWhere((element) => element['Id'] == widget.nama);
            var suhu = int.parse(data['Suhu']);
            return Container(
              padding: EdgeInsets.all(16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TemplateStackDetailSuratMasuk(
                        title: 'Id',
                        sub: data['Id'],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Kelembapan',
                        sub: "${data['Kelembapan'].toString()} RH",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Ketinggian',
                        sub: "${data['Ketinggian'].toString()} cm",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Suhu',
                        sub: "${data['Suhu'].toString()} C",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Tanggal',
                        sub: data['Tanggal'],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Waktu',
                        sub: data['Waktu'],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TemplateStackDetailSuratMasuk(
                        title: 'Status Pintu',
                        sub: suhu < 20 ? "Terbuka" : "Tertutup",
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      // Center(
                      //     child: ButtonWidget(
                      //   onPressed: () {
                      //     var lat = double.parse(data['lat']);
                      //     var long = double.parse(data['long']);
                      //
                      //     Nav.push(
                      //         context,
                      //         MapsScreen(
                      //           lat: lat,
                      //           long: long,
                      //         ));
                      //   },
                      //   child: TemplateTextWidget(
                      //     title: "Lihat Lokasi",
                      //   ),
                      // )),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
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
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/maps_screen.dart';
import 'package:protoype_pintar_iot/widget/button_widget_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/stack_detail_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key key,
      this.nama,
      this.data,
      this.suhu,
      this.kelembapan,
      this.ketinggian,
      this.waktu,
      this.tanggal})
      : super(key: key);
  final String nama;
  final String suhu;
  final String kelembapan;
  final String ketinggian;
  final String waktu;
  final String tanggal;
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
    var suhu = int.parse(widget.suhu);
    return ScaffoldWidget(
      title: "Detail " + widget.nama,
      child: Container(
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
                  sub: widget.nama,
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Kelembapan',
                  sub: "${widget.kelembapan} %",
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Ketinggian',
                  sub: "${widget.ketinggian} cm",
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Suhu',
                  sub: "${widget.suhu} C",
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Tanggal',
                  sub: widget.tanggal,
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Waktu',
                  sub: widget.waktu,
                ),
                SizedBox(
                  height: 10,
                ),
                TemplateStackDetailSuratMasuk(
                  title: 'Status Pintu',
                  sub: suhu > 38 ? "Terbuka" : "Tertutup",
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/stack_detail_widget.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key, this.nama, this.data}) : super(key: key);
  final String nama;
  final Map<dynamic, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Detail " + nama,
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
                  sub: data['Id'],
                ),
                SizedBox(
                  height: 10,
                ),TemplateStackDetailSuratMasuk(
                  title: 'Kelembapan',
                  sub: data['Kelembapan'].toString(),
                ),
                SizedBox(
                  height: 10,
                ),TemplateStackDetailSuratMasuk(
                  title: 'Ketinggian',
                  sub: data['Ketinggian'].toString(),
                ),
                SizedBox(
                  height: 10,
                ),TemplateStackDetailSuratMasuk(
                  title: 'Suhu',
                  sub: data['Suhu'].toString(),
                ),
                SizedBox(
                  height: 10,
                ),TemplateStackDetailSuratMasuk(
                  title: 'Tanggal',
                  sub: data['Tanggal'],
                ),
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

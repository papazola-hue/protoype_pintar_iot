import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/stack_detail_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class CreditScreen extends StatefulWidget {
  // static const routeName = '/credit';
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  List<Map<String, dynamic>> _tableValue = [
    {
      'no': '1',
      'name': 'Universitas',
      'sub': ':',
      'title': 'UNIVERSITAS SEBELAS MARET SEKOLAH VOKASI',
    },
    {
      'no': '1',
      'name': 'Pengembang',
      'sub': ':',
      'title': 'Al Ariq Surya Sadmoko',
    },
    {
      'no': '1',
      'name': 'Pembimbing',
      'sub': ':',
      'title': 'Nanang Maulana Yoeseph, S.Si., M. Cs',
    },
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double width = MediaQuery.of(context).size.width;
    return ScaffoldWidget(
      title: "Halaman Credit",
      child: Center(
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 16, top: 24),
          height: size.height * 0.7,
          width: size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: SingleChildScrollView(
              child: Column(
            children: [
              TemplateStackDetailSuratMasuk(
                title: 'Universitas',
                sub: "UNIVERSITAS SEBELAS MARET SEKOLAH VOKASI",
                angka: 2,
              ),
              TemplateStackDetailSuratMasuk(
                title: 'Pengembang',
                sub: "Al Ariq Surya Sadmoko",
                angka: 2,
              ),
              TemplateStackDetailSuratMasuk(
                title: 'Pembimbing',
                sub: "Nanang Maulana Yoeseph, S.Si., M. Cs",
                angka: 2,
              )
            ],
          )),
        ),
      ),
    );
  }
}

class TemplateAlign extends StatelessWidget {
  final String title;

  const TemplateAlign({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: TemplateTextWidget(
        title: title,
        warna: Colors.black,
        size: 18,
      ),
    );
  }
}

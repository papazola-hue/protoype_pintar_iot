import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class CreditScreen extends StatefulWidget {
  // static const routeName = '/credit';
  @override
  _CreditScreenState createState() => _CreditScreenState();
}

class _CreditScreenState extends State<CreditScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Halaman Credit",
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemplateAlign(
              title: 'Universitas Sebelas Maret ',
            ),
            TemplateAlign(
              title: 'Sekolah Vokasi',
            ),
            SizedBox(
              height: 10,
            ),
            TemplateAlign(
              title: 'Al Ariq Surya Sadmoko',
            ),
            TemplateAlign(
              title: 'M3117007',
            ),
            SizedBox(
              height: 10,
            ),
            TemplateAlign(
              title: 'Pembimbing : Pak Nanang',
            ),
          ],
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

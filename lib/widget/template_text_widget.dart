import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplateTextWidget extends StatelessWidget {
  final String title;
  final Color warna;
  final double size;
  final FontWeight fontWeight;

  const TemplateTextWidget({
    Key key,
    this.title,
    this.warna,
    this.size = 14,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title == null ? '' : title,
      style: GoogleFonts.poppins(
          textStyle:
              TextStyle(color: warna, fontSize: size, fontWeight: fontWeight)),
    );
  }
}

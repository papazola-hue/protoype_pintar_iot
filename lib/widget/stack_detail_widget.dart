import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class TemplateStackDetailSuratMasuk extends StatelessWidget {
  final String title;
  final String sub;

  const TemplateStackDetailSuratMasuk({Key key, this.title, this.sub})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 5,
      crossAxisSpacing: 1,
      children: [
        TemplateTextWidget(
          title: title,
          size: 16,
        ),
        TemplateTextWidget(
          title: sub,
          size: 16,
        )
      ],
    );
  }
}

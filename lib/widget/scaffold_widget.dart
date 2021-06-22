import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({Key key, this.child, this.appBar, this.title}) : super(key: key);
  final Widget child;
  final PreferredSizeWidget appBar;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TemplateTextWidget(
          title: title,
          size: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: child,
    );
  }
}

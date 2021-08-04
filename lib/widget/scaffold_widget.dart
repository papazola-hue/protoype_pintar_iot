import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({Key key, this.child, this.appBar, this.title})
      : super(key: key);
  final Widget child;
  final PreferredSizeWidget appBar;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.purple.shade50,
        elevation: 0,
        title: TemplateTextWidget(
          title: title,
          size: 24,
          warna: Colors.black,
        ),
      ),
      body: child,
    );
  }
}

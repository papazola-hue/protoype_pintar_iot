import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
// import 'package:get/get.dart';5
import 'package:protoype_pintar_iot/screen/credit_screen.dart';
import 'package:protoype_pintar_iot/screen/history_screen.dart';
import 'package:protoype_pintar_iot/widget/template_card_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext cozntext) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TemplateTextWidget(
          title: 'HomePage',
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TemplateCardWidget(
              title: 'History',
              fn: () {
                Nav.push(context, HistoryScreen());
              },
            ),
            TemplateCardWidget(
              title: 'Credit',
              fn: () {
                Nav.push(context, CreditScreen());
              },
            )
          ],
        ),
      ),
    );
  }
}

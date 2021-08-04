import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/credit_screen.dart';
import 'package:protoype_pintar_iot/screen/history_screen.dart';
import 'package:protoype_pintar_iot/screen/item_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_card_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class DataStatistik {
  final String title;
  final String kelembapan;
  final charts.Color color;

  DataStatistik(this.title, this.kelembapan, Color color)
      : this.color = charts.Color(
            r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<dynamic, dynamic>> lists = [];
  List<DataStatistik> data1 = [];
  List<DataStatistik> data2 = [];

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  Widget build(BuildContext cozntext) {
    return ScaffoldWidget(
      withiconLeading: false,
      title: "Dashboard",
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            TemplateTextWidget(
              title: 'Aktivitas',
              size: 16,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildBoxDashboard(
                    function: () {
                      Nav.push(context, ItemScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildCircleIcon(
                            icon: FontAwesomeIcons.tools,
                            warna: Color(0xFFe0f2f1)),
                        SizedBox(
                          height: 16,
                        ),
                        TemplateTextWidget(
                          title: 'Alat',
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )),
                SizedBox(
                  width: 20,
                ),
                buildBoxDashboard(
                    function: () {
                      Nav.push(context, CreditScreen());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildCircleIcon(
                            icon: FontAwesomeIcons.users,
                            warna: Color(0xffFFF0F5)),
                        SizedBox(
                          height: 16,
                        ),
                        TemplateTextWidget(
                          title: 'Credit',
                          size: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),

            // TemplateCardWidget(
            //   title: 'History',
            //   widget: Icon(FontAwesomeIcons.history),
            //   fn: () {
            //     Nav.push(context, HistoryScreen());
            //   },
            // ),
            // TemplateCardWidget(
            //   title: 'Credit',
            //   widget: Icon(FontAwesomeIcons.userAlt),
            //   fn: () {
            //     Nav.push(context, CreditScreen());
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  Container buildCircleIcon({IconData icon, Color warna}) {
    return Container(
      width: 60,
      height: 60,
      child: Icon(
        icon,
        size: 20,
      ),
      decoration: BoxDecoration(shape: BoxShape.circle, color: warna),
    );
  }

  Widget buildBoxDashboard({Widget child, VoidCallback function}) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.all(16),
        height: 200,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: child,
      ),
    );
  }
}

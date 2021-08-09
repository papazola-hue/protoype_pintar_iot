import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/detail_screen.dart';
import 'package:protoype_pintar_iot/screen/graphic_cart_screen.dart';
import 'package:protoype_pintar_iot/screen/history_screen.dart';
import 'package:protoype_pintar_iot/widget/button_widget_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:intl/intl.dart';

class ListGraphicItemScreen extends StatefulWidget {
  // static const routeName = '/history';
  final FirebaseApp app;

  const ListGraphicItemScreen({Key key, this.app}) : super(key: key);

  @override
  _ListGraphicItemScreenState createState() => _ListGraphicItemScreenState();
}

class _ListGraphicItemScreenState extends State<ListGraphicItemScreen> {
  // final referenceDatase = FirebaseDatabase.instance;
  final historyController = TextEditingController();
  var date = DateTime.now();
  List<Map<dynamic, dynamic>> lists = [];

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("Alat");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ref = referenceDatase.reference();
    return ScaffoldWidget(
      title: "List Alat",
      child: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            try {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
              if (snapshot.hasError) {
                return Container(
                    child: Center(
                        child: TemplateTextWidget(
                  title: "Periksa Koneksi dan Ulangi Aplikasi",
                )));
              }
              if (snapshot.hasData) {
                lists.clear();

                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                lists.sort((a, b) => a['no'].compareTo(b['no']));
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    padding: EdgeInsets.all(16),
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: ListTile(
                          onTap: () => Nav.push(
                              context,
                              GraphicCardScreen(
                                id: lists[index]["Id"].toString(),
                              )),
                          title: TemplateTextWidget(
                            title:
                                "Nama Alat : ${lists[index]["Name"].toString()}",
                            size: 16,
                          ),
                          subtitle: TemplateTextWidget(
                            title: "ID Alat : ${lists[index]["Id"].toString()}",
                            size: 16,
                          ),
                        ),
                      );
                    });
              } else {
                return Container(
                    child: Center(
                        child: TemplateTextWidget(
                  title: "Data Kosong",
                )));
              }
            } catch (e) {
              print(e);
              return Container(
                  child: Center(
                      child: TemplateTextWidget(
                title: "Periksa Koneksi dan Ulangi Aplikasi",
              )));
            }
          }),
    );
  }
}

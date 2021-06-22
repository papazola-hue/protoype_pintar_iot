import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/Helper/helper_route.dart';
import 'package:protoype_pintar_iot/screen/detail_screen.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  // static const routeName = '/history';
  final FirebaseApp app;

  const HistoryScreen({Key key, this.app}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // final referenceDatase = FirebaseDatabase.instance;
  final historyController = TextEditingController();
  var date = DateTime.now();
  List<Map<dynamic, dynamic>> lists = [];

  // DatabaseReference db;
  final dbRef = FirebaseDatabase.instance.reference().child("History");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final ref = referenceDatase.reference();
    return ScaffoldWidget(
      title: "Halaman History",
      child: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            try {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
              if(snapshot.hasError){
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
                          onTap: () {
                            Nav.push(
                                context,
                                DetailPage(
                                  nama: lists[index]["Id"].toString(),
                                  data: lists[index],
                                ));
                          },
                          title: TemplateTextWidget(
                            title: lists[index]["Id"].toString(),
                            size: 16,
                          ),
                          subtitle: TemplateTextWidget(
                            title: "Tanggal : " +
                                DateFormat.MMMMEEEEd('id').format(
                                    DateFormat("yyyy-MM-dd").parse(
                                        lists[index]["Tanggal"].toString())),
                          ),
                        ),
                      );
                    });
              }else{
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

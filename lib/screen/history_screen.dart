import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:protoype_pintar_iot/widget/template_card_history.dart';
// import 'package:protoype_pintar_iot/widget/template_card_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class HistoryScreen extends StatefulWidget {
  // static const routeName = '/history';
  final FirebaseApp app;

  const HistoryScreen({Key key, this.app}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final referenceDatase = FirebaseDatabase.instance;
  final historyController = TextEditingController();
  var date = DateTime.now();
  DatabaseReference _historyRef;
  @override
  void initState() {
    super.initState();
    final FirebaseDatabase database = FirebaseDatabase(app: widget.app);
    _historyRef = database.reference().child('History');
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _historyRef.keepSynced(true);
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatase.reference();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TemplateTextWidget(
            title: 'History',
          ),
        ),
        body: FirebaseAnimatedList(
          query: _historyRef,
          padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            return TemplateCardHistoryWidget(
              title: 'Kelembapan : ' + snapshot.value['Kelembapan'],
              subtitle: 'Suhu :' + snapshot.value['Suhu'].toString(),
              date: 'Tanggal :' + snapshot.value['tanggal'],
            );
          },
        ));
  }
}

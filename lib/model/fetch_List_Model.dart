import 'package:firebase_database/firebase_database.dart';

class ModelHistory {
  final String id;
  final String kelembapan;
  final String ketinggian;
  final String tanggal;
  final String suhu;
  final String waktu;


  ModelHistory({
    this.id,
    this.kelembapan,
    this.ketinggian,
    this.tanggal,
    this.suhu,
    this.waktu,
  });

  ModelHistory.fromSnapshot(DataSnapshot snapshot) :
        id = snapshot.value["id"],
        kelembapan = snapshot.value["Kelembapan"],
        ketinggian = snapshot.value["Ketinggian"],
        suhu = snapshot.value["Suhu"],
        tanggal = snapshot.value["Tanggal"],
        waktu = snapshot.value["Waktu"];

  toJson() {
    return {
      "id": id,
      "suhu": suhu,
      "kelembapan": kelembapan,
      "ketinggian": ketinggian,
      "tanggal": tanggal,
      "waktu": waktu,
    };
  }
}
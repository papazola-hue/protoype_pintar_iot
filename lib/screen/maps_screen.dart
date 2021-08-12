import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';
import 'package:protoype_pintar_iot/widget/template_text_widget.dart';

class MapsScreen extends StatefulWidget {
  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  List<Marker> markers = [];
  List<Map<dynamic, dynamic>> lists = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final dbRef = FirebaseDatabase.instance.reference().child("Alat");
  static const LatLng showLocation = const LatLng(-7.5592034, 110.7487715);

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Maps",
      child: FutureBuilder(
          future: dbRef.once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            // try {
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
              markers = lists.map((e) {
                var lat = double.parse(e['lat'].toString());
                var long = double.parse(e['long'].toString());
                var latlng = LatLng(lat, long);
                return Marker(
                  markerId: MarkerId(latlng.toString()),
                  draggable: false,
                  infoWindow: InfoWindow( //popup info
                    title: e['Id'],
                    snippet: e['Name']
                  ),
                  onTap: () {
                    print('Marker Tapped');
                  },
                  position:
                      LatLng(double.parse(e['lat'].toString()), double.parse(e['long'].toString())),
                  icon: BitmapDescriptor.defaultMarker,
                );
              }).toList();
              return GoogleMap(
                mapType: MapType.normal,
                zoomGesturesEnabled: true,
                //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: LatLng(-7.558666, 110.8561135), //initial position
                  zoom: 15.0, //initial zoom level
                ),

                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: Set.from(markers),
              );
            } else {
              return Container(
                  child: Center(
                      child: TemplateTextWidget(
                title: "Data Kosong",
              )));
            }
            // } catch (e) {
            //   print(e.toString());
            //   return Container(
            //       child: Center(
            //           child: TemplateTextWidget(
            //     title: "Periksa Koneksi dan Ulangi Aplikasi",
            //   )));
            // }
          }),
    );
  }
}

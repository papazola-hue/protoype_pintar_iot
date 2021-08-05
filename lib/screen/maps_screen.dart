import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:protoype_pintar_iot/widget/scaffold_widget.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({Key key, this.lat, this.long}) : super(key: key);
  final double lat;
  final double long;

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  double lat = -7.566667;
  double long = 110.816667;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat = widget.lat;
    long = widget.long;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Maps",
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, long),
          bearing: 192.8334901395799,
          tilt: 59.440717697143555,
          zoom: 19.151926040649414,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}

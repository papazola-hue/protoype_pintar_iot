import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:protoype_pintar_iot/screen/home_screen.dart';
// import 'package:protoype_pintar_iot/screen/splash_screen.dart';
// import 'package:protoype_pintar_iot/Helper/route.dart' as router;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Prototype Radiasi IOT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // onGenerateRoute: router.generateRoute,
      home: HomeScreen(),
    );
  }
}

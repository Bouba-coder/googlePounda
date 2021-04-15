import 'package:flutter/material.dart';
//import "file:///C:/Users/bouba/OneDrive/Bureau/flutterProject/google_maps_implement/lib/rabe/googleApi.dart";

import 'package:google_maps_implement/places.dart';
import 'rabe/googleGeolocation.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google_Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Places(title: 'Geolocation'),
      //home: GoogleApi(),
      //home: MyHomePage(),
    );
  }
}

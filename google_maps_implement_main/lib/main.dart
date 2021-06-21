import 'package:flutter/material.dart';
import 'package:google_maps_implement/architecture/presentation/location_picker_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google_Map',
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //primarySwatch: Colors.blue,
        //backgroundColor: Colors.black,
      ),
      //home: Places(title: 'Geolocation'),
      home: LocationPickerPage(),
    );
  }
}

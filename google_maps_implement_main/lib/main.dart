import 'package:flutter/material.dart';
import 'package:google_maps_implement/architecture/presentation/location_picker_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LocationPickerPage(),
    );
  }
}

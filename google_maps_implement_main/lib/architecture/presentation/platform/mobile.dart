

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mobile extends StatefulWidget {
  @override
  _MobileState createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  late CameraPosition _cameraPosition;


  @override
  void initState() {
    _cameraPosition = CameraPosition(target: LatLng(0.0, 0.0), zoom: 20.0);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GoogleMap(initialCameraPosition: _cameraPosition)
    ],);
  }
}

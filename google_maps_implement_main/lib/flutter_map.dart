import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_implement/ui_class/floating_search_bar.dart';

class FlutterMap extends StatefulWidget {
  @override
  _FlutterMapState createState() => _FlutterMapState();
}

class _FlutterMapState extends State<FlutterMap> {

  //flutter floating search bar
  FloatingSearchBarNativeWidget floatingSearchBarNativeWidget = new FloatingSearchBarNativeWidget(marginTop: 20.2);
  //google map
  late GoogleMapController mapController;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(43.1801553, 2.9929898999999978), zoom: 20.0,);
  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    floatingSearchBarNativeWidget.marginTop;
    return Scaffold(
      appBar: AppBar(
        title: Text("FlutterMap"),
      ),

      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
            mapType: MapType.terrain,
          ),
          floatingSearchBarNativeWidget,
        ],
      ),
    );
  }
}

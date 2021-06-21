import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as web;
import 'package:google_maps_implement/architecture/domain/geolocation.dart';
import 'package:google_maps_implement/architecture/infrastructure/geocoding.dart';
import 'package:google_maps_implement/architecture/infrastructure/places.dart';
import 'package:google_maps_implement/architecture/presentation/widgets/floating_search_bar_widget.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class Web extends StatefulWidget {
  @override
  _WebState createState() => _WebState();
}

class _WebState extends State<Web> {
  late GoogleMapController _googleMapController;
  late FloatingSearchBarController _floatingSearchBarController;

  CameraPosition _cameraPosition = CameraPosition(target: LatLng(28.385233, -81.563873), zoom: 10);
  Marker _marker = Marker(markerId: MarkerId('start'));

  Geocoding _geocoding = Geocoding();
  Places _places = Places();
  String _address = "";

  List<LocationResultAddress> locations = [];
  LatLng latLng = LatLng(0.0, 0.0);



  @override
  void initState() {
    _floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  void dispose() {
    _floatingSearchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition,
          onMapCreated: (controller) {
            setState(() {
            _googleMapController = controller;
            });
          },
          mapType: MapType.normal,
          onTap: (latLng) async{
            _address = (await _geocoding.findAddress(latLng.latitude, latLng.longitude))!;
          },
          markers: {
            _marker
          },
        ),
        // FloatingSearchBarWidget(
        //     floatingSearchBarController: _floatingSearchBarController,
        //     onQueryChanged: (query) async{
        //       locations = (await _places.getSuggestions(query))!;
        //     },
        //     children: [
        //         ListView.builder(
        //             itemCount: locations.length,
        //             itemBuilder: (context, index){
        //           final item = locations[index];
        //           return SizedBox();
        //           return ListTile(
        //             title: Text(item.address),
        //             onTap: (){
        //               setState(() async{
        //                 latLng = (await _geocoding.getCoordinates(item.address))!;
        //                 _address = (await  _geocoding.findAddress(latLng.latitude, latLng.longitude))!;
        //                 _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(latLng.latitude, latLng.longitude), zoom: 15.0)));
        //               });
        //             },
        //           );
        //         })
        // ])
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../domain/geolocation.dart';
import '../../infrastructure/geocoding.dart';
import '../../infrastructure/geolocator.dart';
import '../../infrastructure/places.dart';
import '../widgets/floating_search_bar_widget.dart';

class IosUI extends StatefulWidget {
  @override
  _IosUIState createState() => _IosUIState();
}

class _IosUIState extends State<IosUI> {
  late GoogleMapController _googleMapController;
  late FloatingSearchBarController _floatingSearchBarController;

  CameraPosition _cameraPosition = CameraPosition(target: const LatLng(28.385233, -81.563873), zoom: 15);

  final Geocoding _geocoding = Geocoding();
  final Places _places = Places();
  String _address = "";

  List<LocationResultAddress> _locations = [];
  LatLng _latLng = const LatLng(28.385233, -81.563873);

  @override
  void initState() {
    _floatingSearchBarController = FloatingSearchBarController();
    _getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _floatingSearchBarController.dispose();
    _googleMapController.dispose();
    super.dispose();
  }


  void _getCurrentLocation() async{
    final Position p = await Geolocator().determinePosition();
    _latLng = LatLng(p.latitude, p.longitude);
    _address = (await _geocoding.findAddress(_latLng.latitude, _latLng.longitude))!;
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 20.0)));
    setState(() {});
  }

  void _updatePosition(LatLng latLng) async{
    _latLng = latLng;
    _address = (await _geocoding.findAddress(latLng.latitude, latLng.longitude))!;
    setState(() {});
  }

  void _updatePositionOnSelect(LocationResultAddress item) async {
    _floatingSearchBarController.close();
    _latLng = (await _geocoding.getCoordinates(item.address))!;
    _address = (await  _geocoding.findAddress(_latLng.latitude, _latLng.longitude))!;
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 20.0)));
    setState(() {});
  }

  void _onQueryChanged(String query) async{
    _locations = (await _places.getSuggestions(query))!;
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _googleMapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height-160,
            child: GoogleMap(
              initialCameraPosition: _cameraPosition,
              onMapCreated: _onMapCreated,
              mapType: MapType.normal,
              onTap: _updatePosition,
              markers: {
                Marker(markerId: MarkerId(_address) , position: LatLng(_latLng.latitude, _latLng.longitude), infoWindow: InfoWindow(title: _address))
              },
            ),
          ),
          FloatingSearchBarWidget(
              marginTop: 10,
              floatingSearchBarController: _floatingSearchBarController,
              onQueryChanged: _onQueryChanged,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: _locations.length,
                    itemBuilder: (context, index){
                      final item = _locations[index];
                      return ListTile(
                        title: Text(item.address),
                        onTap: (){
                          _updatePositionOnSelect(item);
                        },
                      );
                    })
              ]),
          Positioned(
            bottom: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  leading: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                  title: _address.isNotEmpty ? Text(_address) : const Align(alignment: Alignment.center, child: CircularProgressIndicator.adaptive(),),
                  trailing: GestureDetector(
                      onTap: (){
                        Navigator.pop(context, LocationResult(latLng: _latLng, address: _address));
                      },
                      child: const Icon(Icons.check)),
                )),
          )
        ],
      ),
    );
  }
}

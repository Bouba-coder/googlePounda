import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  CameraPosition _cameraPosition = CameraPosition(target: LatLng(28.385233, -81.563873), zoom: 15);

  Geocoding _geocoding = Geocoding();
  Places _places = Places();
  String _address = "";

  List<LocationResultAddress> _locations = [];
  LatLng _latLng = LatLng(28.385233, -81.563873);

  @override
  void initState() {
    _floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  void dispose() {
    _floatingSearchBarController.dispose();
    _googleMapController.dispose();
    super.dispose();
  }


  _updatePosition(LatLng latLng) async{
    _latLng = latLng;
    _address = (await _geocoding.findAddress(latLng.latitude, latLng.longitude))!;
    setState(() {});
  }

  _updatePositionOnSelect(LocationResultAddress item) async {
    _floatingSearchBarController.close();
    _latLng = (await _geocoding.getCoordinates(item.address))!;
    _address = (await  _geocoding.findAddress(_latLng.latitude, _latLng.longitude))!;
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 20.0)));
    setState(() {});
  }

  _onQueryChanged(query) async{
    _locations = (await _places.getSuggestions(query))!;
    setState(() {});
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      _googleMapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _cameraPosition,
            onMapCreated: _onMapCreated,
            mapType: MapType.normal,
            onTap: _updatePosition,
            markers: {
              Marker(markerId: MarkerId(_address) , position: LatLng(_latLng.latitude, _latLng.longitude), infoWindow: InfoWindow(title: _address))
            },
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
            bottom: 60,
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
                height: 100,
                child: Card(
                  color: Colors.black,
                  elevation: 4,
                  child: Center(child: Text(_address, style: TextStyle(color: Colors.white),),),)),
          )
        ],
      ),
    );
  }
}

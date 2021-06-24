import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import '../../domain/geolocation.dart';
import '../../infrastructure/geocoding.dart';
import '../../infrastructure/places.dart';
import '../widgets/floating_search_bar_widget.dart';

class DesktopUI extends StatefulWidget {
  @override
  _DesktopUIState createState() => _DesktopUIState();
}

class _DesktopUIState extends State<DesktopUI> {
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


  _updatePositionOnSelect(LocationResultAddress item) async {
    _floatingSearchBarController.close();
    _latLng = (await _geocoding.getCoordinates(item.address))!;
    _address = (await  _geocoding.findAddress(_latLng.latitude, _latLng.longitude))!;
    setState(() {});
  }

  _onQueryChanged(String query) async{
    _locations = (await _places.getSuggestions(query))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            child: Center(child: Icon(Icons.error_outline_rounded, size: 150, color: Colors.red,),),
            decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/world_map.jpg'), colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.dstATop))
          ),),
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
          if(_address.isNotEmpty)
            Positioned(
              bottom: 0,
              child: Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Theme.of(context).primaryColor,
                    elevation: 4,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      leading: GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back_ios)),
                      title: Text(_address),
                      trailing: GestureDetector(
                          onTap: (){
                            Navigator.pop(context, LocationResult(latLng: _latLng, address: _address));
                          },
                          child: const Icon(Icons.check)),
                    ),)),
            )
        ],
      ),
    );
  }
}

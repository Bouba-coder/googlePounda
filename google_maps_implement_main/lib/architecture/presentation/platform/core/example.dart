
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Example{




  Future<ModelDvo> getCurrentLocation(Function() fn) async{
    final ModelDvo modelDvo = ModelDvo();

    final Position p = await Geolocator().determinePosition();
    modelDvo.latLng = LatLng(p.latitude, p.longitude);
    modelDvo.address = (await _geocoding.findAddress(_latLng.latitude, _latLng.longitude))!;
    modelDvo.googleMapController = _googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: _latLng, zoom: 20.0)));
    fn;
    return modelDvo;
  }
}

//Dvo = Data View Object
//Dto = Data Transfert object



//DAO = Data Access Object  = Service  != data class

class ModelDvo{

  ModelDvo({this.latLng, this.address, this.googleMapController});

  LatLng? latLng;
  String? address;
  GoogleMapController googleMapController;
}
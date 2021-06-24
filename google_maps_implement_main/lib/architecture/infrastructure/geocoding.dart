
import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class Geocoding{

  final String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  final String baseUrl ='https://maps.googleapis.com/maps/api/geocode/json';

  Future<LatLng?> getCoordinates(String address) async {
    try{
      final url = Uri.parse('$baseUrl?address=$address&key=$apiKey');
      final response = await http.get(url);
      if(response.statusCode == 200){
        final result = json.decode(response.body)['results'];
        final LatLng latLng = LatLng(result[0]['geometry']['location']['lat'] as double, result[0]['geometry']['location']['lng'] as double);
        return latLng;
      }
      return null;
    }catch (e){
      throw Exception(e);
    }

  }

  Future<String?> findAddress(double latitude, double longitude) async {
    try{
      final url = Uri.parse('$baseUrl?latlng=$latitude,$longitude&key=$apiKey');
      final response = await http.get(url);
      if (response.statusCode == 200){
        final result = json.decode(response.body)['results'];
        return result[0]['formatted_address'] as String;
      }
      return null;
    }catch (e){
      throw Exception(e);
    }

  }

}
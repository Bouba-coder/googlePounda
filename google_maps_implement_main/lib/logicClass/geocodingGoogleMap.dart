import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart';

class GeocodingGoogleMapping {
  double latitudeCoordi = 0.0;
  double longitudeCoordi = 0.0;
  String address;
  String input;
  String apiGeocodingMapKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/geocode/json';
  final client = new Client();

  //constructor
  //GeocodingGoogleMap(this.input);
  //addressTrad to coordinates
  void fetchSuggestions(String input) async
  {
    String request = "$baseURL?address=$input&key=$apiGeocodingMapKey";
    //getting responses
    final  responses = await client.get(request);
    //print("response.body");
    //print(responses.body);
    if (responses.statusCode == 200)
    {
      final result = json.decode(responses.body)['results'];
      print("texte result: ");
      print("latitude : ${result[0]['geometry']['location']['lat']}");
      print("longitude : ${result[0]['geometry']['location']['lng']}");
      latitudeCoordi = result[0]['geometry']['location']['lat'];
      longitudeCoordi = result[0]['geometry']['location']['lng'];
    } else
    {
      throw Exception('Failed to fetch suggestion');
    }
  }

  //get address from lat and long
  void fetchAddress(double lat, double long) async
  {
    String request = "$baseURL?latlng=$lat,$long&key=$apiGeocodingMapKey";
    //getting responses
    final  responses = await client.get(request);
    //print("${responses.body}");
    if (responses.statusCode == 200)
    {
      final result = json.decode(responses.body)['results'];
      //print("texte result: $result");
      print("texte result: ${result[0]['formatted_address']}");
      address = result[0]['formatted_address'];
    }
    else{
      throw Exception('Failed to fetch suggestion');
    }
    //print(responses.body);

  }


}

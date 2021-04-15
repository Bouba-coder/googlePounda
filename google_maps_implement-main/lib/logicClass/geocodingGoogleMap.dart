import 'dart:convert';
//import 'dart:io';
//import 'package:google_maps_implement/logicClass/geocodingParse.dart';
import 'package:http/http.dart';

class GeocodingGoogleMapping {
  double latitudeCoordi = 0.0;
  double longitudeCoordi = 0.0;
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


}

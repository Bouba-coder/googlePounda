import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart';

class GeocodingGoogleMapping {
  double latitudeCoordi = 0.0;
  double longitudeCoordi = 0.0;
  String address="";
  String input="";
  String apiGeocodingMapKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/geocode/json';
  final client = new Client();

  //constructor
  //GeocodingGoogleMap(this.input);
  //addressTrad to coordinates
  void fetchSuggestions(String input) async
  {
    //var url =
    //Uri.https('https://maps.googleapis.com', '/maps/api/geocode/json?address=$input&key=$apiGeocodingMapKey', {'q': '{$input}'});
    var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$input&key=$apiGeocodingMapKey');
    var responses = await client.get(url);
    // Await the http get response, then decode the json-formatted response.
    String request = "$baseURL?address=$input&key=$apiGeocodingMapKey";
    //getting responses
    //final  responses = await client.get(request);
    print("responseFetchSuggestions : ${responses.body}");
    //print(responses.body);
    if (responses.statusCode == 200)
    {
      final result = json.decode(responses.body)['results'];
      print("texte result: $result");
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
    //var url =
    //Uri.https('https://maps.googleapis.com', '/maps/api/geocode/json?latlng=$lat,$long&key=$apiGeocodingMapKey', {'q': '{$lat,$long}'});
    var url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apiGeocodingMapKey');
    var responses = await client.get(url);
    String request = "$baseURL?latlng=$lat,$long&key=$apiGeocodingMapKey";
    //getting responses
    //final  responses = await client.get(request);
    //print("${responses.body}");
    print("responseFetchAddress : ${responses.body}");
    if (responses.statusCode == 200)
    {
      final result = json.decode(responses.body)['results'];
      //print("texte result: $result");
      //print("texteFetchAddressresult: ${result[0]['formatted_address']}");
      address = result[0]['formatted_address'];
    }
    else{
      throw Exception('Failed to fetch suggestion');
    }
    //print(responses.body);

  }


}

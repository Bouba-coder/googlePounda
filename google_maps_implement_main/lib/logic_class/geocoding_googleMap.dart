import 'dart:convert';
import 'package:google_maps_implement/data_class/location.dart';
import 'package:http/http.dart';

class GeocodingGoogleMapping
{
  double latitudeCoordi = 0.0;
  double longitudeCoordi = 0.0;
  LatLng geoLatLng = LatLng(0.0, 0.0);
  String address = "je suis là";
  String apiGeocodingMapKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/geocode/json';
  final client = new Client();

  void fetchSuggestions(String input) async
  {
    //Await the http get response, then decode the json-formatted response.
    //getting responses
    var url = Uri.parse('$baseURL?address=$input&key=$apiGeocodingMapKey');
    var responses = await client.get(url);
    //print("responseFetchSuggestions : ${responses.body}");
    final result = json.decode(responses.body)['results'];
    //print(responses.body);
    if (responses.statusCode == 200)
    {

      //print("texte result: $result");
      latitudeCoordi = result[0]['geometry']['location']['lat'];
      longitudeCoordi = result[0]['geometry']['location']['lng'];
      final LatLng latLngResult = LatLng(latitudeCoordi, longitudeCoordi);
      geoLatLng = latLngResult;
      print("geoLatLng : ${geoLatLng.latitude}");
      print("geoLatLng : ${geoLatLng.longitude}");

    } else
    {
      throw Exception('Failed to fetch suggestion');
    }
  }

  //get address from lat and long
  void fetchAddress(double lat, double long) async
  {
    var url = Uri.parse('$baseURL?latlng=$lat,$long&key=$apiGeocodingMapKey');
    var responses = await client.get(url);
    //getting responses
    //print("${responses.body}");
    print("responseFetchAddress : ${responses.body}");
    if (responses.statusCode == 200)
    {
      final result = json.decode(responses.body)['results'];
      //print("texte result: $result");
      //print("texteFetchAddressresult: ${result[0]['formatted_address']}");
      address = result[0]['formatted_address'];
      final LocationResultAddress add = LocationResultAddress(address: address);
      address = add.address;
    }
    else
      {
      throw Exception('Failed to fetch suggestion');
    }

  }


}

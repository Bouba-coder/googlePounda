import 'dart:convert';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';
import '../data_class/location.dart';


class AddressSuggestion {
  final List<LocationResultAddress> placeList = [];
  String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  String baseURLDetails ='https://maps.googleapis.com/maps/api/place/details/json?place_id';
  var uuid = new Uuid();
  late String sessionToken;
  final client = new Client();


  //address suggestion place description
  void getSuggestion(String input) async
  {
    sessionToken = uuid.v4();
    //getting data
    var url = Uri.parse(
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken&language=fr');
    var responses = await client.get(url);

    if (responses.statusCode == 200)
    {
      for (var prediction in json.decode(responses.body)['predictions'])
      {
        final element = prediction;
        final place_id = element['place_id'];
        final description = element['description'];
        final LocationResultAddress locationResultAddress = new LocationResultAddress(address: description, placeId: place_id);
        //locationResultAddress.placeId = place_id;
        print("geoLatLng : ${description}");
        placeList.add(locationResultAddress);
      }
    }
  }

  //future
  Future<List<LocationResultAddress>>getFuture(String input) async {
    var uuid = new Uuid();
    var sessionToken = uuid.v4();
    String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final client = new Client();
    //getting data
    var url = Uri.parse(
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken&language=fr');
    var responses = await client.get(url);

      for (var prediction in json.decode(responses.body)['predictions'])
      {
        final element = prediction;
        final place_id = element['place_id'];
        final description = element['description'];
        final LocationResultAddress locationResultAddress = LocationResultAddress(address: description, placeId: place_id);
        //locationResultAddress.placeId = place_id;
        print("geoLatLng : ${description}");
        placeList.add(locationResultAddress);

      }
    return placeList;
  }

  //getPlaceDetailFromId more informations about place
    //Future<Place> getPlaceDetailFromId(String placeId) async {
    getPlaceDetailFromId(String placeId) async {
      sessionToken = uuid.v4();
      final request = Uri.parse('$baseURLDetails=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken');
      final response = await client.get(request);

      if (response.statusCode == 200)
      {
        final result = json.decode(response.body);
        //print('getPlaceDetailFromId : $result');
        if (result['status'] == 'OK')
        {
          final components = result['result']['address_components'] as List<dynamic> ;
          // build result
          final place = Place();
          //recuperation de details avec le placeid
          components.forEach((c)
          {
            final List type = c['types'];
            if (type.contains('street_number'))
            {
              place.streetNumber = c['long_name'];
            }
            if (type.contains('route'))
            {
              place.street = c['long_name'];
            }
            if (type.contains('locality'))
            {
              place.city = c['long_name'];
            }
            if (type.contains('postal_code'))
            {
              place.zipCode = c['long_name'];
            }
          });
          return place;
        }
        throw Exception(result['error_message']);
      } else {
        throw Exception('Failed to fetch suggestion');
      }
    }

}

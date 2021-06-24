
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'dart:convert';

import '../domain/geolocation.dart';

class Places {

  final String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  final String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  final String baseURLDetails ='https://maps.googleapis.com/maps/api/place/details/json?place_id';

  Future<List<LocationResultAddress>?> getSuggestions(String input) async{
    try{
      final url = Uri.parse(
          '$baseURL?input=$input&key=$apiKey&sessiontoken=${Uuid().v4()}&language=fr');
      final response = await http.get(url);
      if (response.statusCode == 200)
      {
        List<LocationResultAddress> l = [];
        for (final prediction in json.decode(response.body)['predictions'])
        {
          final LocationResultAddress locationResultAddress = LocationResultAddress(address: prediction['description'] as String, placeId: prediction['place_id'] as String);
          l.add(locationResultAddress);
        }
        return l;
      }
      return null;
    }catch (e){
      throw Exception(e);
    }
  }

  Future<Place?> getPlaceDetail(String placeId) async{
    final request = Uri.parse('$baseURLDetails=$placeId&fields=address_component&key=$apiKey&sessiontoken=${Uuid().v4()}');
    final response = await http.get(request);

    if (response.statusCode == 200)
    {
      final result = json.decode(response.body);
      if (result['status'] == 'OK')
      {
        final components = result['result']['address_components'] as List<dynamic> ;
        final place = Place();
        components.map((c)
        {
          final List type = c['types'] as List<dynamic>;
          if (type.contains('street_number'))
          {
            place.streetNumber = c['long_name'] as String;
          }
          if (type.contains('route'))
          {
            place.street = c['long_name'] as String;
          }
          if (type.contains('locality'))
          {
            place.city = c['long_name'] as String;
          }
          if (type.contains('postal_code'))
          {
            place.zipCode = c['long_name'] as String;
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
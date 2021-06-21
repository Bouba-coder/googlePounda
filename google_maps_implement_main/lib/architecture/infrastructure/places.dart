import 'package:google_maps_implement/architecture/domain/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'dart:convert';

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
        for (var prediction in json.decode(response.body)['predictions'])
        {
          final LocationResultAddress locationResultAddress = new LocationResultAddress(address: prediction['description'], placeId: prediction['place_id']);
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
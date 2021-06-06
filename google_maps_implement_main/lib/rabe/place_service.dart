import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import '../data_class/location.dart';



//suggestion class
class Suggestion
{
  late String placeId;
  late String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}


class PlaceApiProvider {

  final client = Client();
  //PlaceApiProvider(this.sessionToken);
  late final sessionToken;
  var uuid = new Uuid();
  final apiKey = 'AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0';

  Future<List<Suggestion>> fetchSuggestionsPlace(String input) async
  {
    sessionToken = uuid.v4();
    final request = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json??input=$input&key=$apiKey&sessiontoken=$sessionToken&language=fr');
    final response = await client.get(request);
    print('fetchSuggestionsPlaceService : ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS')
      {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final components =
        result['result']['address_components'] as List<dynamic>;
        // build result
        //final place = Place(street: '', streetNumber: '', zipCode: '', city: '');
        final place = Place();
        components.forEach((c) {
          final List type = c['types'];
          if (type.contains('street_number')) {
            place.streetNumber = c['long_name'];
          }
          if (type.contains('route')) {
            place.street = c['long_name'];
          }
          if (type.contains('locality')) {
            place.city = c['long_name'];
          }
          if (type.contains('postal_code')) {
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
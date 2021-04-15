import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';


class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();
  PlaceApiProvider(this.sessionToken);
  final sessionToken;
  static final String androidKey = 'AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0';
  static final String iosKey = 'AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
   //final request = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=es-ES&components=country:ec&key=$apiKey&sessiontoken=$sessionToken';
    //final request = 'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0&language=fr&input=pizza+near%20par';
    //final request = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=geocode&language=fr&key=$apiKey";
   String baseURL ='https://maps.googleapis.com/maps/api/place/queryautocomplete/json';
   String request =
       '$baseURL?input=$input&key=AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0&sessiontoken=$sessionToken&language=fr';

   final responses = await client.get(request);
    if (responses.statusCode == 200) {
      final result = json.decode(responses.body)['predictions'];
      print("texte: ");
      print(result);
      return result;
      if (result['place_id'] != null) {
        // compose suggestions in a list
        //print(result["predictions"]);
        print("something");
        return result['predictions'].map<Suggestion>((p) => Suggestion(p['place_id'], p['description'])).toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        print("nothing");
        return [];

      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }


}
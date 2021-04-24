import 'dart:convert';
//import 'dart:io';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class AddressSuggestion {
  List<dynamic> placeList = [];
  late String input;
  late Uri request;
  String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  var uuid = new Uuid();
  late String sessionToken;
  final client = new Client();


  //address suggestion
  void getSuggestion(String input) async {
    sessionToken = uuid.v4();
    //request = '';
    //getting data
    //var response = await client.get(request);
    var url = Uri.parse('$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken&language=fr');
    var responses = await client.get(url);
    //print(response.headers);
    print('getSuggestionResponses : ${responses.body}');
    if (responses.statusCode == 200)
    {
        placeList = json.decode(responses.body)['predictions'];
        print("textePlaceList : $placeList");
    } else {
      throw Exception('Failed to load predictions');
    }
  }

}

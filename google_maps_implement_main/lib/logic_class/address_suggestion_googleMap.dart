import 'dart:convert';
//import 'dart:io';
import 'package:google_maps_implement/data_class/result.dart';
import 'package:google_maps_implement/logic_class/address_predictions.dart';
import 'package:google_maps_implement/logic_Class/place_service.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

import 'location.dart';
import 'location.dart';
import 'location.dart';
import 'location.dart';
import 'location.dart';

class AddressSuggestion {
  final List<LocationResult> placeList = [];
  late String input;
  late String status;
  late List<Predictions> predictions;
  String apiKey ="AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
  String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
  var uuid = new Uuid();
  late String sessionToken;
  final client = new Client();


  //address suggestion
  void getSuggestion(String input) async {
    sessionToken = uuid.v4();
    //getting data
    var url = Uri.parse(
        '$baseURL?input=$input&key=$apiKey&sessiontoken=$sessionToken&language=fr');
    var responses = await client.get(url);


    if (responses.statusCode == 200) {
      for (var prediction in json.decode(responses.body)['predictions']) {
        final element = prediction;
        final PID = element['place_id'];
        final DESC = element['description'];

        final LatLng latLng = LatLng(10.0, 10.0);
        final LocationResult locationResult = LocationResult(
            latLng: latLng, address: DESC);
        locationResult.placeId = PID;
        placeList.add(locationResult);
      }
    }


    //
    //
    //   Prediction res = new Prediction(responses.body, responses.statusCode.toString());
    //
    //   //print(response.headers);
    //   print('getSuggestionResponsesBody : ${responses.body}');
    //   if (responses.statusCode == 200)
    //   {
    //       placeList = json.decode(responses.body)['predictions'];
    //       //print("getSuggestionPlaceList : $placeList");
    //       print("getPredictions---->getPredictions : ${res.status}${res.results}");
    //       //print("PredictionsPrediction---->PredictionsPrediction : ${pre.description}");
    //       //print("PredictionsPrediction---->PredictionsPrediction : ${placeList.map<SuggestionPred>((p) => Suggestion(p['place_id'], p['description'])).toList()}");
    //       print("PredictionsPrediction---->SuggestionPred : ${placeList.map<SuggestionPred>((p) =>  SuggestionPred(p['description']))}");
    //
    //       //print("getSuggestionPlaceList : ${placeList.map<Suggestion>((p) => Suggestion(p['place_id'], p['description'])).toList()}");
    //       //test class addreP
    //       //Predictions shippingFromJson(String str) => Predictions.fromJson(json.decode(str));
    //       //String shippingToJson(Predictions data) => json.encode(data.toJson());
    //       predictions = json.decode(responses.body);
    //       //var test = shippingFromJson(responses.body.toString());
    //       //var test = shippingToJson();
    //       //print('test : ${test}');
    //       //predictions.add(Predictions.fromJson(json.decode(responses.body)));
    //       //_searchResult.add(StoreDetails.fromJson(responseJson));
    //       status = "ok";
    //       //var addPred = new AddressPredictions(predictions: predictions, status: status);
    //       //print('addPredPredictions: ${addPred.predictions}');
    //       //print('reasonPhrase : ${responses.reasonPhrase}');
    //     //return placeList.map<Suggestion>((p) => Suggestion(p['place_id'], p['description'])).toList();
    //
    //   } else {
    //     throw Exception('Failed to load predictions');
    //   }
    // }

    // Future<Place> getPlaceDetailFromId(String placeId) async {
    //   sessionToken = uuid.v4();
    //   final request = Uri.parse(
    //       'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component&key=$apiKey&sessiontoken=$sessionToken');
    //   final response = await client.get(request);
    //
    //   if (response.statusCode == 200) {
    //     final result = json.decode(response.body);
    //     print('getPlaceDetailFromId : $result');
    //     if (result['status'] == 'OK')
    //     {
    //       final components = result['result']['address_components'] as List<dynamic> ;
    //       // build result
    //       //final place = Place(street: '', streetNumber: '', zipCode: '', city: '');
    //       final place = Place();
    //       components.forEach((c) {
    //         final List type = c['types'];
    //         if (type.contains('street_number'))
    //         {
    //           place.streetNumber = c['long_name'];
    //         }
    //         if (type.contains('route'))
    //         {
    //           place.street = c['long_name'];
    //         }
    //         if (type.contains('locality'))
    //         {
    //           place.city = c['long_name'];
    //         }
    //         if (type.contains('postal_code'))
    //         {
    //           place.zipCode = c['long_name'];
    //         }
    //       });
    //       return place;
    //     }
    //     throw Exception(result['error_message']);
    //   } else {
    //     throw Exception('Failed to fetch suggestion');
    //   }
    // }
  }
}

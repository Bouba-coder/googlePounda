import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_implement/logicClass/geocodingGoogleMap.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart';


class Places extends StatefulWidget {
  Places({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  var _controller = TextEditingController();
  var uuid = new Uuid();
  String _sessionToken;
  List<dynamic> _placeList = [];
  String _address = "";

  //calling geocode object
  GeocodingGoogleMapping geocode = new GeocodingGoogleMapping();

  @override
  //init to subscribe and listen to _controller
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  //api call
  void getSuggestion(String input) async {
    final client = Client();
    String PLACES_API_KEY = "AIzaSyBKKc8CuRH_wZG7xBXZhvkpo_oRMzMMRp0";
    //String type = '(regions)';
    String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken&language=fr';
    //getting data

    var response = await client.get(request);
    //print(response.headers);
    //print(response.body);
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
        print("texte : $_placeList");
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    geocode.fetchSuggestions(_controller.text);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: "Enter your address",
                    focusColor: Colors.white,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    prefixIcon: Icon(Icons.map),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_placeList[index]["description"]),
                    onTap: (){
                      setState(() {
                        if(_placeList.isEmpty){
                          _address = _controller.text;
                        }else {
                          _controller.text = _placeList[index]["description"].toString();
                          _address = _controller.text;
                        }
                      });
                    },
                  );
                },
              ),
              Text("Address : $_address "),
              Text("Address to Coordinate(Latitude and longitude) ${geocode.latitudeCoordi} : ${geocode.longitudeCoordi}"),
            ],
          ),
        ),
      ),
    );
  }
}
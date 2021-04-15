import 'package:flutter/material.dart';

import '../rabe/place_service.dart';
//import 'file:///C:/Users/bouba/OneDrive/Bureau/flutterProject/google_maps_implement/lib/rabe/place_service.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  final sessionToken;
  PlaceApiProvider apiClient;
  AddressSearch(this.sessionToken){
    apiClient =  PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: query == "" ? null : apiClient.fetchSuggestions(query),
      builder: (context, snapshot) => query == ""
          ? Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Enter your address'),
      )
          : snapshot.hasData
          ? ListView.builder(
        itemBuilder: (context, i) => ListTile(
          // we will display the data returned from our future here
          title: Text((snapshot.data[i] as Suggestion).description),
          onTap: () {},

        ),
        itemCount: snapshot.data.length,
      )
          : Container(child: Center(child: CircularProgressIndicator(),)),
    );
  }
}
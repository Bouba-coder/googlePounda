import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_implement/logic_class/address_suggestion_googleMap.dart';
import 'package:google_maps_implement/logic_class/geocoding_googleMap.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class Places extends StatefulWidget {
  Places({Key? key, this.title}) : super(key: key);
  late final String? title;

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places>
{

  var _controller = TextEditingController();
  var _searchBarFloatingController = FloatingSearchBarController();
  var uuid = new Uuid();
  String? _sessionToken;
  LatLng tappedPointLatLng = LatLng(0,0);
  //list for adding marquers
  List<Marker> myMarker = [];

  //calling geocode object
  GeocodingGoogleMapping geocode = new GeocodingGoogleMapping();
  //calling address suggestion
  AddressSuggestion suggestionAddress = new AddressSuggestion();
  //calling map...
  late GoogleMapController mapController;
  //final LatLng _center = const LatLng(45.521563, -122.677433);
  CameraPosition initialPosition = CameraPosition(target: LatLng(0.0, 0.0), zoom: 20.0,);
  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }

  //add marker method
  _addMarker(LatLng tappedPoint) {
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(
          Marker(
            //icon: customIcon,
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
          )
      );
    }
    );
    tappedPointLatLng = tappedPoint;
    geocode.longitudeCoordi = tappedPointLatLng.longitude;
    geocode.latitudeCoordi = tappedPointLatLng.latitude;
    _searchBarFloatingController.query = geocode.addressPoint;
    //geocode.address = geocode.address;
    geocode.fetchAddress(tappedPointLatLng.latitude, tappedPointLatLng.longitude);
  }

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
        //geocode.fetchSuggestions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //customIcon
    geocode.latitudeCoordi = tappedPointLatLng.latitude;
    geocode.longitudeCoordi = tappedPointLatLng.longitude;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        //padding: const EdgeInsets.fromLTRB(8.0, 1.0, 8.0, 0.0),
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: initialPosition,
            mapType: MapType.normal,
            onTap: _addMarker,
            markers: {
              //Set.from(myMarker)
              Marker(
                  markerId: MarkerId(tappedPointLatLng.toString()),
                  position: LatLng(geocode.latitudeCoordi, geocode.longitudeCoordi),
                  infoWindow: InfoWindow(title: geocode.addressPoint),
                  //icon: customIcon,
              )
            },
          ),
          searchBarWidget(),
          _buildContainer(),
        ],
      ),
    );
  }

  //floatingsearch
  Widget searchBarWidget(){
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      //backdropColor: Colors.black.withOpacity(0.7),
      backgroundColor: Colors.black,
      queryStyle: TextStyle(color: Colors.white),
      controller: _searchBarFloatingController,
      hintStyle: TextStyle(color: Colors.white),
      hint: "Search your address",
      openAxisAlignment: 0.0,
      //maxWidth:  600,
      axisAlignment: isPortrait ? 0.0 : -1.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      elevation: 4.0,
      onQueryChanged: (query)
      {
        setState(() {
          //pl.fetchSuggestionsPlace(query);
          //calling data methods
          //getting lat, long
          _controller.text = query;
          geocode.fetchSuggestions(query);
          //getting address suggestion
          suggestionAddress.getSuggestion(query);
          print("querry : $query");
          print("_searchBarFloatingController : ${_searchBarFloatingController.query}");
        });

      },
      //showDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(icon: Icon(Icons.place,color: Colors.white,),
              onPressed: ()
              {
                print('places Pressed');
                //_searchBarFloatingController.query = geocode.address;
                print('_searchBarFloatingController : ${_searchBarFloatingController.query}');
              }),
        ),

        //clearing search
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
          color: Colors.white,
        )
      ],

      //builder
      builder: (context, transition){
        return ClipRRect(
          child: Material(
            color: Colors.white.withOpacity(0.3),
            elevation: 4.0,
            child: Container(
              //height: 200.0,
              color: Colors.black.withOpacity(0.6),
              child: Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      //itemCount: _placeList.length,
                      itemCount: suggestionAddress.placeList.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          //leading: Text('address', style: TextStyle(color: Colors.black87),),
                          title: Text(suggestionAddress.placeList[index].address, style: TextStyle(color: Colors.white),),
                          //subtitle: Text(suggestionAddress.placeList[index].placeId.toString(), style: TextStyle(color: Colors.black),),
                          onTap: (){
                            print("je clique");
                            setState(()
                            {
                              mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(geocode.latitudeCoordi, geocode.longitudeCoordi), zoom: 18.0)));
                              _addMarker(LatLng(geocode.latitudeCoordi, geocode.longitudeCoordi));
                              //geocode.address = suggestionAddress.placeList[index].address;
                              geocode.addressPoint = suggestionAddress.placeList[index].address;
                              geocode.fetchSuggestions(geocode.addressPoint);
                            });
                            suggestionAddress.placeList.clear();
                          },
                        );
                      }
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildContainer(){
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.5, horizontal: 10.5),
        height: 70.5,
        width: 260.5,
        decoration: new BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(10.1),
        ),
        //child: Text("${tappedPointLatLng.latitude}, ${tappedPointLatLng.longitude}"),
        child: Text("${geocode.latitudeCoordi}, ${geocode.longitudeCoordi}, ${geocode.addressPoint}", style: TextStyle(color: Colors.white, fontSize: 14.1),),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_implement/logic_class/address_suggestion_googleMap.dart';
import 'package:google_maps_implement/logic_class/geocoding_googleMap.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

//import 'package:pounda/presentation/core/theme/index.dart';
import 'package:google_maps_implement/presentation/theme_style_impl.dart';
//import 'package:google_maps_implement/presentation/value_translaters.dart';

class FloatingSearchBarNativeWidget extends StatelessWidget {
  //variables
  final double marginTop;
  final Function(String)? onQueryChanged;
  final List<Widget> children;
  final FloatingSearchBarController? floatingSearchBarController;
  final Color? backdropColor;


  //constructor
  const FloatingSearchBarNativeWidget({
    Key? key,
    required this.children,
    this.floatingSearchBarController,
    this.backdropColor,
    this.marginTop = 0,
    this.onQueryChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: floatingSearchBarController,
      automaticallyImplyBackButton: false,
      borderRadius: BorderRadius.circular(20.2),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      backdropColor: backdropColor ?? Colors.transparent,
      shadowColor: Theme.of(context).colorScheme.primary,
      margins: EdgeInsets.only(left: 15, right: 15, top: marginTop),
      hint: 'search',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      openWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: onQueryChanged,
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        FloatingSearchBarAction.hamburgerToBack(),
      ],
      actions: [FloatingSearchBarAction.searchToClear()],
      builder: (context, transition) {
        return new ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            // color: Colors.white,
            elevation: 4.0,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        );
      },
    );
  }
}



class MySearchBar extends StatefulWidget {
  @override
  _MySearchBarState createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {

  late FloatingSearchBarController _floatingSearchBarController;

  //parti map
  LatLng startPoint = LatLng(0,0);
  List<Marker> myMarker = [];
  late GoogleMapController mapController;
  String presentation = "StartPoint";
  //suggestion
  AddressSuggestion address = new AddressSuggestion();
  //geocode
  GeocodingGoogleMapping getGeocode = new GeocodingGoogleMapping();

  //map camera
  CameraPosition initialPosition = CameraPosition(target: LatLng(0.0, 0.0), zoom: 3.0,);
  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }

  //google map adding marker after clicked
  _addMarker(LatLng tappedPoint) {
    setState(() {
      getGeocode.fetchAddress(tappedPoint.latitude, tappedPoint.longitude);
      myMarker = [];
      myMarker.add(
          Marker(
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            infoWindow: InfoWindow(title: getGeocode.addressPoint)
          )
      );
      startPoint = tappedPoint;
    });
      print(" tappedPoint : $tappedPoint");
      print("geocoding address ${getGeocode.addressPoint}");
      presentation = getGeocode.addressPoint;

  }


  @override
  void initState() {
    _floatingSearchBarController = FloatingSearchBarController();
    super.initState();
  }

  @override
  void dispose() {
    _floatingSearchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GoogleMap"),
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

              Marker(
                markerId: MarkerId(startPoint.toString()),
                position: LatLng(startPoint.latitude, startPoint.longitude),
                //infoWindow: InfoWindow(title: presentation),
                infoWindow: InfoWindow(title: getGeocode.addressPoint),
                //icon: customIcon,
              )
            },
          ),
       FloatingSearchBarNativeWidget(
         floatingSearchBarController: _floatingSearchBarController,
            children: [
              new ListView.builder(
                  shrinkWrap: true,
                  itemCount: address.placeList.length,
                  itemBuilder: (context, index)
                  {
                    return ListTile(
                      title: new Text("${address.placeList[index].address.toString()}"),
                      onTap: (){
                        print("je clicke");
                        setState(() {
                          getGeocode.fetchSuggestions(address.placeList[index].address);
                          print(" geocode : ${getGeocode.geoLatLng}");
                          getGeocode.fetchAddress(getGeocode.latitudeCoordi, getGeocode.longitudeCoordi);
                          presentation = getGeocode.addressPoint;
                          _floatingSearchBarController.close();
                          Future.delayed(Duration(seconds: 2), (){
                            LatLng l = LatLng(getGeocode.geoLatLng.latitude, getGeocode.geoLatLng.longitude);
                            _addMarker(l);
                            startPoint = l;
                            mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(getGeocode.latitudeCoordi, getGeocode.longitudeCoordi), zoom: 15.0)));

                          });

                        });
                      },
                    );
                  }
              ),
        ], onQueryChanged: (query)
        {
          print("query : $query");
          setState(() {
            address.getSuggestion(query );
          });
        },
        ),
        ],
      ),
    );
  }
}

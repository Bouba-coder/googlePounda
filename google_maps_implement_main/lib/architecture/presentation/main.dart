

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_implement/architecture/domain/geolocation.dart';

import 'location_picker_page.dart';

Future<LocationResult?> googleMapLocationPicker(BuildContext context) async{
  final result = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => LocationPickerPage()));
  return (result == null) ? null : result as LocationResult;
}



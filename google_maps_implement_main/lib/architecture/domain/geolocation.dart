// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:google_maps_flutter/google_maps_flutter.dart';

/// The result returned after completing location selection.
class LocationResult {
  /// The human readable name of the location. This is primarily the
  /// name of the road. But in cases where the place was selected from Nearby
  /// places list, we use the <b>name</b> provided on the list item.
  String address; // or road

  /// Google Maps place ID
  String? placeId;

  /// Latitude/Longitude of the selected location.
  LatLng latLng;

  LocationResult({required this.latLng, required this.address, this.placeId});

  @override
  String toString() {
    return 'LocationResult{address: $address, latLng: $latLng, placeId: $placeId}';
  }
}

/// The result returned after completing location selection.
class LocationResultAddress {
  /// Google Maps place address
  String address; // or road
  /// Google Maps place ID
  String? placeId;


  LocationResultAddress({required this.address, this.placeId});

  @override
  String toString() {
    return 'LocationResultAddress{address: $address, placeId: $placeId}';
  }
}

///places attribute class
class Place
{
  /// Google Maps place details
  late String? streetNumber;
  late String? street;
  late String? city;
  late String? zipCode;

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
  });

  @override
  String toString()
  {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode)';
  }
}
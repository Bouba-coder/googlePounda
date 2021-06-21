// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show hashValues;

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

/// A pair of latitude and longitude coordinates, stored as degrees.
// class LatLng {
//   /// Creates a geographical location specified in degrees [latitude] and
//   /// [longitude].
//   ///
//   /// The latitude is clamped to the inclusive interval from -90.0 to +90.0.
//   ///
//   /// The longitude is normalized to the half-open interval from -180.0
//   /// (inclusive) to +180.0 (exclusive)
//   const LatLng(double latitude, double longitude)
//       : assert(latitude != null),
//         assert(longitude != null),
//         latitude =
//         (latitude < -90.0 ? -90.0 : (90.0 < latitude ? 90.0 : latitude)),
//         longitude = (longitude + 180.0) % 360.0 - 180.0;
//
//   /// The latitude in degrees between -90.0 and 90.0, both inclusive.
//   final double latitude;
//
//   /// The longitude in degrees between -180.0 (inclusive) and 180.0 (exclusive).
//   final double longitude;
//
//   /// Converts this object to something serializable in JSON.
//   Object toJson() {
//     return <double>[latitude, longitude];
//   }
//
//   /// Initialize a LatLng from an \[lat, lng\] array.
//   static LatLng? fromJson(Object? json) {
//     if (json == null) {
//       return null;
//     }
//     assert(json is List && json.length == 2);
//     final list = json as List;
//     return LatLng(list[0] as double, list[1] as double);
//   }
//
//   @override
//   String toString() => '$runtimeType($latitude, $longitude)';
//
//   @override
//   bool operator ==(Object o) {
//     return o is LatLng && o.latitude == latitude && o.longitude == longitude;
//   }
//
//   @override
//   int get hashCode => hashValues(latitude, longitude);
// }
//
// /// A latitude/longitude aligned rectangle.
// ///
// /// The rectangle conceptually includes all points (lat, lng) where
// /// * lat ∈ [`southwest.latitude`, `northeast.latitude`]
// /// * lng ∈ [`southwest.longitude`, `northeast.longitude`],
// ///   if `southwest.longitude` ≤ `northeast.longitude`,
// /// * lng ∈ [-180, `northeast.longitude`] ∪ [`southwest.longitude`, 180],
// ///   if `northeast.longitude` < `southwest.longitude`
// class LatLngBounds {
//   /// Creates geographical bounding box with the specified corners.
//   ///
//   /// The latitude of the southwest corner cannot be larger than the
//   /// latitude of the northeast corner.
//   LatLngBounds({required this.southwest, required this.northeast})
//       : assert(southwest != null),
//         assert(northeast != null),
//         assert(southwest.latitude <= northeast.latitude);
//
//   /// The southwest corner of the rectangle.
//   final LatLng southwest;
//
//   /// The northeast corner of the rectangle.
//   final LatLng northeast;
//
//   /// Converts this object to something serializable in JSON.
//   Object toJson() {
//     return <Object>[southwest.toJson(), northeast.toJson()];
//   }
//
//   /// Returns whether this rectangle contains the given [LatLng].
//   bool contains(LatLng point) {
//     return _containsLatitude(point.latitude) &&
//         _containsLongitude(point.longitude);
//   }
//
//   bool _containsLatitude(double lat) {
//     return (southwest.latitude <= lat) && (lat <= northeast.latitude);
//   }
//
//   bool _containsLongitude(double lng) {
//     if (southwest.longitude <= northeast.longitude) {
//       return southwest.longitude <= lng && lng <= northeast.longitude;
//     } else {
//       return southwest.longitude <= lng || lng <= northeast.longitude;
//     }
//   }
//
//   /// Converts a list to [LatLngBounds].
//   @visibleForTesting
//   static LatLngBounds? fromList(Object? json) {
//     if (json == null) {
//       return null;
//     }
//     assert(json is List && json.length == 2);
//     final list = json as List;
//     return LatLngBounds(
//       southwest: LatLng.fromJson(list[0])!,
//       northeast: LatLng.fromJson(list[1])!,
//     );
//   }
//
//   @override
//   String toString() {
//     return '$runtimeType($southwest, $northeast)';
//   }
//
//   @override
//   bool operator ==(Object o) {
//     return o is LatLngBounds &&
//         o.southwest == southwest &&
//         o.northeast == northeast;
//   }
//
//   @override
//   int get hashCode => hashValues(southwest, northeast);
// }


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
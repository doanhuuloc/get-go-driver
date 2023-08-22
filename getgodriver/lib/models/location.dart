import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  String title;
  String summary;
  String placeID;
  LatLng coordinates;
  double heading;
  LocationModel(
      {required this.title,
      required this.summary,
      this.placeID = '',
      this.heading=0,
      this.coordinates = const LatLng(10.7454, 106.7323)});
}

import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';

class LocationViewModel with ChangeNotifier {
  LocationModel myLocation = LocationModel(title: '', summary: '');
}

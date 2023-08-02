import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/widgets/map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class GoogleMapBuider {
  LocationModel _currentLocation;
  LocationModel? _desLocation;
  List<PointLatLng> _listPoint = [];
  List<LatLng> _listDrive = [];
  String _icon = "assets/svgs/CarMap.svg";
  GoogleMapBuider({required LocationModel currentLocation})
      : _currentLocation = currentLocation;

  GoogleMapBuider updateIconCurrent(String icon) {
    _icon = icon;
    return this;
  }

  GoogleMapBuider setDesLocation(LocationModel location) {
    _desLocation = location;
    return this;
  }

  GoogleMapBuider setPolyline(List<PointLatLng> listPoint) {
    _listPoint = listPoint;
    return this;
  }

  GoogleMapBuider setListDrive(List<LatLng> listDrive) {
    _listDrive = listDrive;
    return this;
  }

  MapScreen build() {
    return MapScreen(
      icon: _icon,
      currentLocation: _currentLocation,
      desLocation: _desLocation,
      listPoint: _listPoint,
      listDrive: _listDrive,
    );
  }
}

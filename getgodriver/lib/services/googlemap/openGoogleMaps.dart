import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OpenGoogleMaps {
  static void openGoogleMaps(LatLng des) async {
    String destinationLatitude = "10.7625";
    String destinationLongitude = "106.6823";
    String mapUrl =
        "https://www.google.com/maps/dir/?api=1&destination=${des.latitude.toString()},${des.longitude.toString()}&travelmode=driving";
    //  final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${TextStrings.homeLat},${TextStrings.homeLng}";

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Không thể mở Google Maps.";
    }
  }
}

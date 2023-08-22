import 'package:url_launcher/url_launcher.dart';

class OpenGoogleMaps {
  static void openGoogleMaps() async {
    String destinationLatitude = "10.7625";
    String destinationLongitude = "106.6823";
    String mapUrl = "geo:$destinationLatitude,$destinationLongitude";
    //  final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${TextStrings.homeLat},${TextStrings.homeLng}";

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Không thể mở Google Maps.";
    }
  }
}

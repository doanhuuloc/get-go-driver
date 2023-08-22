// // import 'package:clientapp_taxi_getgo/configs/configDev.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class Directions {
//   List<PointLatLng> polylinePoints;
//   double totalDistance;
//   String totalDuration;

//   Directions({
//     required this.polylinePoints,
//     required this.totalDistance,
//     required this.totalDuration,
//   });

//   factory Directions.fromMap(Map<String, dynamic> map) {
//     final data = Map<String, dynamic>.from(map['routes'][0]['polyline']['encodedPolyline']);

//     double distance = data['distanceMeters'] / 1000;
//     String duration =
//         (double.tryParse(data['duration'].replaceAll('s', ''))! / 60)
//             .round()
//             .toString();
//     return Directions(
//       polylinePoints:
//           PolylinePoints().decodePolyline(map['routes'][0]['polyline']['encodedPolyline']),
//       // polylinePoints: Developer.PountLat,
//       totalDistance: distance,
//       totalDuration: duration,
//     );
//   }
//   // factory Directions.fromMap(Map<String, dynamic> map) {
//   //   // Check if route is not available
//   //   // if ((map['routes'] as List).isEmpty) return null;
//   //   print(map);
//   //   // Get route information
//   //   List<PointLatLng> polylineCoordinates = [];
//   //   // final data = Map<String, dynamic>.from(map['routes']['legs']);
//   //   List<dynamic> legs = map['route']['legs'];
//   //   List<dynamic> maneuvers = legs[0]['maneuvers'];

//   //   for (var maneuver in maneuvers) {
//   //     double lat = maneuver['startPoint']['lat'];
//   //     double lng = maneuver['startPoint']['lng'];
//   //     polylineCoordinates.add(PointLatLng(lat, lng));
//   //   }

//   //   return Directions(
//   //     polylinePoints: polylineCoordinates,
//   //     // polylinePoints: Developer.PountLat,
//   //     totalDistance: '10',
//   //     totalDuration: '20',
//   //   );
//   // }
// }

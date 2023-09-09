import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/services/DioInterceptorManager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class APIPlace {
  static final _dioInterceptorManager = DioInterceptorManager();
  static final Dio _dio = _dioInterceptorManager.dioInstance;

  static Future<List<LocationModel>> getSuccession(String input) async {
    String kPlace_API_Key = "AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w";
    String bareURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$bareURL?input=$input&components=country:VN&key=$kPlace_API_Key';
    final response = await _dio.get(request);
    print(response);
    print('responseaa');
    if (response.statusCode == 200) {
      List<dynamic> predictions = response.data['predictions'];
      List<LocationModel> locations = [];
      // Giới hạn chỉ lấy 5 địa điểm
      int limit = 5;
      for (int i = 0; i < predictions.length && i < limit; i++) {
        String name = predictions[i]['structured_formatting']['main_text'];
        String description = predictions[i]['description'];
        String placeID = predictions[i]['place_id'];
        locations.add(
            LocationModel(title: name, summary: description, placeID: placeID));
      }
      return locations;
    } else {
      throw Exception('fail to load data');
    }
  }

  static Future<LatLng> getLatLng(String placeID) async {
    String kPlace_API_Key = "AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w";
    String bareURL = 'https://maps.googleapis.com/maps/api/place/details/json';
    String request = '$bareURL?key=$kPlace_API_Key&place_id=$placeID';
    final response = await _dio.get(request);
    LatLng location = const LatLng(0, 0);

    if (response.statusCode == 200) {
      double lat = response.data['result']['geometry']['location']['lat'];
      double lng = response.data['result']['geometry']['location']['lng'];
      location = LatLng(lat, lng);
    }
    return location;
  }

  static Future<String> getDirections(
      {required LatLng origin, required LatLng destination}) async {
    try {
      print('cout<< ooi doi oi');
      final url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

      final headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w',
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
      };

      final body = {
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude
            }
          }
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude
            }
          }
        },
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "departureTime": "2023-10-15T15:01:23.045123456Z",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false
        },
        "languageCode": "en-US",
        "units": "IMPERIAL"
      };

      final response =
          await _dio.post(url, options: Options(headers: headers), data: body);
      print('cout<< helloq242');
      print(response);
      if (response.statusCode == 200) {
        // Successful response
        // TODO: Handle and display the response data as per your requirement
        // print(response.data);
        // PolylinePoints().decodePolyline(
        //     response.data['routes'][0]['polyline']['encodedPolyline']);

        return response.data['routes'][0]['polyline']['encodedPolyline'];
      }
      throw Exception('Request failed with status: ${response.statusCode}');
    } catch (e) {
      print("cout<< neeee $e");
      throw Exception('Request failed with status: ');
    }
  }

  static Future<Map<String, dynamic>> getDirectionAndDistance(
      {required LatLng origin, required LatLng destination}) async {
    print('cout<<<<<$origin');
    print('cout<<<<<$destination');
    try {
      print('cout<< ooi doi oi');
      final url = 'https://routes.googleapis.com/directions/v2:computeRoutes';

      final headers = {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyBLAnygT3LzvYGdMD43t12_zw79CXC0O2w',
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
      };

      final body = {
        "origin": {
          "location": {
            "latLng": {
              "latitude": origin.latitude,
              "longitude": origin.longitude
            }
          }
        },
        "destination": {
          "location": {
            "latLng": {
              "latitude": destination.latitude,
              "longitude": destination.longitude
            }
          }
        },
        "travelMode": "DRIVE",
        "routingPreference": "TRAFFIC_AWARE",
        "departureTime": "2023-10-15T15:01:23.045123456Z",
        "computeAlternativeRoutes": false,
        "routeModifiers": {
          "avoidTolls": false,
          "avoidHighways": false,
          "avoidFerries": false
        },
        "languageCode": "en-US",
        "units": "IMPERIAL"
      };

      final response =
          await _dio.post(url, options: Options(headers: headers), data: body);
      print('cout<< helloq242');
      print(response);
      if (response.statusCode == 200) {
        // Successful response
        // TODO: Handle and display the response data as per your requirement
        // print(response.data);
        // PolylinePoints().decodePolyline(
        //     response.data['routes'][0]['polyline']['encodedPolyline']);
        // print('cout<<<< ${response.data}');
        // print('cout<<<< ${response.data['routes'][0]['distanceMeters']}');
        // print('cout<<<< ${response.data['routes'][0]['duration']}');
        double distance = response.data['routes'][0]['distanceMeters'] / 1000;
        String duration = (double.parse(response.data['routes'][0]['duration']
                    .replaceAll('s', '')) /
                60)
            .round()
            .toString();
        Map<String, dynamic> detail = {
          "polylinePoints": response.data['routes'][0]['polyline']
              ['encodedPolyline'],
          "distance": distance,
          "duration": duration,
        };
        return detail;
      }
      throw Exception('Request failed with status: ${response.statusCode}');
    } catch (e) {
      print("cout<< neeee $e");
    }
    throw Exception('Request failed with status: ');
  }

  // static Future<LatLng> getCurrentLocation() async {
  //   try {
  //     await Permission.location.request();
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     print('ydddđfffffffff');
  //     print(position.accuracy);
  //     LatLng location = LatLng(position.latitude, position.longitude);
  //     return location;
  //   } catch (e) {
  //     throw Exception('Request failed with status: $e}');
  //   }
  // }

  static Future<LocationModel> getAddressFromLatLng(
      double latitude, double longitude) async {
    // print("cout<<" + latLng.toString());
    LocationModel location = LocationModel(
        title: '',
        summary: '',
        placeID: '',
        coordinates: LatLng(latitude, longitude));
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude,
          localeIdentifier: "vn");
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        location.title = placemark.subAdministrativeArea as String;
        location.summary =
            "${placemark.street}, ${placemark.subAdministrativeArea}, ${placemark.administrativeArea}, ${placemark.country}";
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      return location;
    }
  }
}

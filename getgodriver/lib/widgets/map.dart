import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final currentLocation = LatLng(10.728728, 106.718796);
  final List<LatLng> destinationLocation = [
    LatLng(10.7757, 106.7004),
    LatLng(10.7240, 106.7356),
    LatLng(10.7094, 106.7320),
    LatLng(10.7219, 106.7281),
  ];
  static const CameraPosition _kLake = CameraPosition(
    // bearing: 192.8334901395799,
    target: LatLng(10.728728, 106.718796),
    // tilt: 59.440717697143555,
    zoom: 16,
  );
  Map<String, Marker> _marker = {};
  Set<Polyline> _polylines = {};
  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: currentLocation,
        zoom: 14,
      ),
      onMapCreated: (GoogleMapController controller) async {
        _controller.complete(controller);
        addMarker('test', currentLocation);
        // addMarker('destination', destinationLocation);
        // addMarker('destination1', destinationLocation1);
        // _createPolylines(currentLocation, destinationLocation);
        // List<LatLng> nearbyPlaces = await DirectionsRepository()
        //     .calculateDistance(currentLocation, destinationLocation);
        // int i = 0;
        // for (LatLng x in nearbyPlaces) {
        //   addMarker('destination${i.toString()}', x);
        //   i++;
        // }
        // print('wwwwwwwwwwwwwwww');
        // print(nearbyPlaces[0]);
        // // destinationLocation1 = nearbyPlaces[0];
        // print(1111111111111);
        // print(DirectionsRepository.destinationLocation1!);
        // await _createPolylines(
        //     currentLocation, nearbyPlaces[0]);
      },
      markers: _marker.values.toSet(),
      compassEnabled: true,
      myLocationEnabled: true,
      // polylines: {
      //   if (_info != null)
      //     Polyline(
      //       polylineId: const PolylineId('overview_polyline'),
      //       color: Colors.blue,
      //       // width: 5,
      //       points: _info!.polylinePoints.map((e) {
      //         print('eeeeeeeeee22222222222222222');
      //         print(e);
      //         return LatLng(e.latitude, e.longitude);
      //       }).toList(),
      //     ),
      // },
    );
    // floatingActionButton: FloatingActionButton.extended(
    //   onPressed: _goToTheLake,
    //   label: const Text('To the lake!'),
    //   icon: const Icon(Icons.directions_boat),
    // ),
    // );
  }

  // Future<void> _createPolylines(LatLng start, LatLng destination) async {
  //   final directions = await DirectionsRepository()
  //       .getDirections(origin: start, destination: destination);
  //   print(destination);
  //   print('dasssssssssssssss');
  //   print(directions.polylinePoints);
  //   setState(() => _info = directions);
  // }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(
        title: 'End Point',
        snippet: 'End Marker',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    );
    _marker[id] = marker;
    setState(() {});
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

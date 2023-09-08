import 'dart:convert';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:getgodriver/configs/api_config.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/api_places.dart';
import 'package:getgodriver/utils/helper.dart';
import 'package:getgodriver/utils/initValue.dart';
import 'package:getgodriver/widgets/home/bottomSheetAcceptTrip.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart';

class SocketService {
  static io.Socket? _socket;
  static late BuildContext _context;
  static updateContext(BuildContext context) {
    _context = context;
  }

  static void connectserver(BuildContext context) {
    print('hhhhhhhh');
    print('hhhhhhhh $_socket');
    _socket = io.io(
        ApiConfig.baseUrl,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .build());

    _socket?.onConnect(
      (data) async {
        print("cout<< connect " + _socket!.id.toString());
        // print(
        //     "cout<< ơi òi ${_context.read<DriverViewModel>().myLocation.coordinates}");
        // driverSendToServer(
        //     _context.read<DriverViewModel>().myLocation.coordinates,
        //     _context.read<DriverViewModel>().myLocation.heading);
        Location location = Location();
        LocationData locationData = await location.getLocation();
        // print('hihihi');
        driverSendToServer(
            LatLng(locationData.latitude!, locationData.longitude!),
            locationData.heading ?? 0);

        receiptClient();
        successReceipt();
        startScheduledTrip();
        driverReconnect();
        receiptMessage();
        // startScheduledCallcenterTrip();
        // receiptClient(context);
      },
    );
    _socket?.onDisconnect((data) {
      print('cout<< disconnect' + data.toString());
    });

    _socket?.onConnectError((data) {
      print("cout<< err: $data");
    });
  }

  static void disconnect() {
    _socket?.disconnect();
  }

  static void receiptMessage() {
    _socket?.on("message-to-driver", (data) {
      DateTime now = DateTime.now();
      String formattedTime = DateFormat('HH:mm').format(now);
      _context.read<TripViewModel>().pushMessage(data, '0', formattedTime);
    });
  }

  static void sendMessage(String text, BuildContext context) {
    _socket?.emit("driver-message", {
      'message': text,
      'user_id': 5,
      'trip_id': context.read<TripViewModel>().id
    });
  }

  static void driverSendToServer(LatLng location, double heading) {
    print('heeeee');
    Map<String, dynamic> data = {
      "user_id": 9,
      'lat': location.latitude,
      'lng': location.longitude,
      'status': "Idle", // Idle,offline,driving
      'heading': heading,
      'vehicle_type': 1 //4 bánh
    };
    _socket?.emit('driver-login', data);
  }

  static void receiptClient() {
    _socket?.on("user-trip", (data) async {
      final trip = _context.read<TripViewModel>();
      print("cout<< trip có chuyến");
      // final jsonData = jsonDecode(data);
      // print('cout<< 11111111111111111111111111111111111111111');
      print('cout<< $data');

      try {
        print('cout<<<<<<<<<<<<<<<<<<<');
        print(data['trip_info']['is_callcenter']);
        data['trip_info']['is_callcenter']
            ? trip.updateInfoCallCenterTrip(data)
            : trip.updateInfoTrip(data);
        // print(data);
        print('cout<< thành công r nè');

        showModalBottomSheet(
          enableDrag: false,
          isDismissible: false,
          context: _context,
          builder: (_context) {
            return BottomSheetAcceptTrip(stripId: data["trip_info"]);
          },
        );
      } catch (e) {
        print("cout<<< $e");
        throw (e);
      }
    });
  }

  static Future<void> handleTripUpdate(
      BuildContext context, String status) async {
    context.read<DriverViewModel>().updateStatus(status);
    String directions = '';
    final trip = context.read<TripViewModel>();
    if (status == "Driving") {
      String directions = await APIPlace.getDirections(
          origin: context.read<DriverViewModel>().myLocation.coordinates,
          destination: trip.toAddress.coordinates);
      await trip.updateDirection(PolylinePoints().decodePolyline(directions));
      print('beff ${trip.id}');
      Map<String, dynamic> data = {
        "trip_id": trip.id,
        "directions": directions,
        "status": status
      };
      _socket?.emit('trip-update', data);
      return;
    } else {
      Map<String, dynamic> data = {
        "trip_id": trip.id,
        "directions": directions,
        "status": status
      };
      _socket?.emit('trip-update', data);
    }
    // print('cout<< tao nèww');
  }

  static void successReceipt() {
    _socket?.on("receive-trip-success", (data) async {
      print('cccccccccccccccccccccccccc');
      final trip = _context.read<TripViewModel>();
      _context.read<DriverViewModel>().updateStatus('Confirmed');
      String directions = await APIPlace.getDirections(
          origin: _context.read<DriverViewModel>().myLocation.coordinates,
          destination: trip.fromAddress.coordinates);
      await trip.updateDirection(PolylinePoints().decodePolyline(directions));

      Navigator.of(_context).pushReplacementNamed(Routes.trip);
    });
  }

  static void failReceipt(BuildContext context) {
    _socket?.on("received-trip-fail", (data) {
      final jsonData = jsonDecode(data);
    });
  }

  static void driverUpdateServer(
      LatLng location, double heading, String directions) {
    print('cout<< dd');
    Map<String, dynamic> data = {
      'lat': location.latitude,
      'lng': location.longitude,
      'heading': heading,
      'directions': directions
    };
    _socket?.emit('driver-location-update', data);
  }

  static void driverIsAccept(Map<String, dynamic> trip, String status) {
    _socket?.emit('driver-response-booking', {'trip': trip, 'status': status});
  }

  static void startScheduledTrip() {
    _socket?.on("schedule-notice", (data) async {
      final trip = _context.read<TripViewModel>();
      final driver = _context.read<DriverViewModel>();
      bool check = data['trip_info']['is_callcenter'];
      print('print($check)');
      check ? trip.updateInfoCallCenterTrip(data) : trip.updateInfoTrip(data);
      driver.updateStatus('Confirmed');
      String directions = await APIPlace.getDirections(
          origin: driver.myLocation.coordinates,
          destination: trip.fromAddress.coordinates);
      await trip.updateDirection(PolylinePoints().decodePolyline(directions));
      Navigator.of(_context)
          .pushNamedAndRemoveUntil(Routes.trip, (route) => false);
    });
  }

  static void driverReconnect() {
    _socket?.on("driver-reconnect", (data) async {
      final trip = _context.read<TripViewModel>();
      final driver = _context.read<DriverViewModel>();
      _context.read<TripViewModel>().updateInfoTrip(data);
      driver.updateStatus(data['trip_info']['status']);
      if (data['trip_info']['status'] == "Confirmed") {
        String directions = await APIPlace.getDirections(
            origin: _context.read<DriverViewModel>().myLocation.coordinates,
            destination: trip.fromAddress.coordinates);
        await trip.updateDirection(PolylinePoints().decodePolyline(directions));
        Navigator.of(_context).pushReplacementNamed(Routes.trip);
      } else if (data['trip_info']['status'] == 'Driving') {
        String directions = await APIPlace.getDirections(
            origin: driver.myLocation.coordinates,
            destination: trip.toAddress.coordinates);
        await trip.updateDirection(PolylinePoints().decodePolyline(directions));
        Navigator.of(_context).pushReplacementNamed(Routes.tripDriving);
      }
    });
  }

  static void newScheduledTrip() {
    _socket?.on("new-scheduled-trip", (data) {});
  }
}

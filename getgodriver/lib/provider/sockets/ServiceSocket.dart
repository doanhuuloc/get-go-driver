import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getgodriver/configs/api_config.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/widgets/home/bottomSheetAcceptTrip.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

class SocketService with ChangeNotifier {
  io.Socket? _socket;

  void connectserver(BuildContext context) {
    _socket = io.io(
        ApiConfig.baseUrl,
        io.OptionBuilder().setTransports(['websocket'])
            // .disableAutoConnect()
            .setQuery({'username': 'loc'}).build());

    _socket?.onConnect(
      (data) {
        Location location = Location();
        location.getLocation().then((location) async {
          driverSendToServer(LatLng(location.latitude!, location.longitude!),
              location.heading ?? 0);
        });
        print('cout<< www');
        successReceipt(context);
        receiptClient(context);
      },
    );
    _socket?.onDisconnect((data) {
      print('disconnect' + data.toString());
    });

    _socket?.onConnectError((data) {
      print("err: $data");
    });
  }

  void disconnect() {
    _socket?.disconnect();
  }

  void driverSendToServer(LatLng location, double heading) {
    Map<String, dynamic> data = {
      "user_id": 2,
      'lat': location.latitude,
      'lng': location.longitude,
      'status': "Idle", // Idle,offline,driving
      'heading': heading,
      'vehicle_type': 1 //4 bánh
    };
    _socket?.emit('driver-login', data);
  }

  void receiptClient(BuildContext context) {
    _socket?.on("user-trip", (data) {
      // final jsonData = jsonDecode(data);
      print('cout<< 11111111111111111111111111111111111111111');
      print(data);
      Map<String, dynamic> trip_infor = jsonDecode(data['trip_info']);
      Map<String, dynamic> user_info = jsonDecode(data['user_info']);
      print(trip_infor);
      print(trip_infor['start'] is String);
      context.read<TripViewModel>().infoTrip = TripModel(
          id: trip_infor['trip_id'] / 1,
          avatar: 'avatar',
          name: user_info['name'],
          phone: user_info['phone'],
          cost: trip_infor['price'] / 1,
          distance: 1, // trip_infor['distance'],
          note: 'note',
          fromAddress: LocationModel(
              title: '',
              summary: jsonDecode(trip_infor['start'])['name'],
              coordinates: LatLng(jsonDecode(trip_infor['start'])['lat'] / 1,
                  jsonDecode(trip_infor['start'])['lng'] / 1)),
          toAddress: LocationModel(
              title: '',
              summary: jsonDecode(trip_infor['end'])['name'],
              coordinates: LatLng(jsonDecode(trip_infor['end'])['lat'] / 1,
                  jsonDecode(trip_infor['end'])['lng'] / 1)),
          paymentMethod: 'momo',
          startDate: DateTime.utc(2023, 7, 25, 16, 00),
          endDate: DateTime.utc(2023, 7, 25, 16, 00));
      print(data);
      showModalBottomSheet(
        enableDrag: false,
        isDismissible: false,
        context: context,
        builder: (context) {
          return BottomSheetAcceptTrip(stripId: data["trip_info"]);
        },
      );
    });
  }

  void handleTripUpdate(BuildContext context, String status) {
    context.read<DriverViewModel>().updateStatus(status);
    print('cout<< tao nèww');
    Map<String, dynamic> data = {
      "trip_id": context.read<TripViewModel>().tripID,
      "status": status
    };
    _socket?.emit('trip-update', data);
  }

  void successReceipt(BuildContext context) {
    _socket?.on("receive-trip-success", (data) {
      context.read<DriverViewModel>().updateStatus('Confirmed');

      Navigator.of(context).pushNamed(Routes.trip);
    });
  }

  void failReceip(BuildContext context) {
    _socket?.on("received-trip-fail", (data) {
      final jsonData = jsonDecode(data);
    });
  }

  void driverUpdateServer(LatLng location, double heading) {
    Map<String, dynamic> data = {
      'lat': location.latitude,
      'lng': location.longitude,
      'heading': heading,
    };
    _socket?.emit('driver-location-update', data);
  }

  void driverIsAccept(Map<String, dynamic> stripId, String status) {
    _socket
        ?.emit('driver-response-booking', {'trip': stripId, 'status': status});
  }
}

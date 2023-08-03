import 'package:flutter/material.dart';
import 'package:getgodriver/configs/api_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class SocketService with ChangeNotifier {
  late io.Socket _socket;
  io.Socket get socket => _socket;

  void connectserver() {
    _socket = io.io(
        ApiConfig.baseUrl,
        io.OptionBuilder().setTransports(['websocket'])
            // .disableAutoConnect()
            .setQuery({'username': 'loc'}).build());
    _socket.onConnect(
      (data) {
        Location location = Location();
        location.getLocation().then((location) async {
          driverSendToServer(LatLng(location.latitude!, location.longitude!),
              location.heading ?? 0);
        });
      },
    );
    _socket.onDisconnect((data) {
      print("disconnect");
    });

    _socket.onConnectError((data) {
      print("err:");
      print(data);
    });
  }

  void disconnect() {
    _socket.disconnect();
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
    _socket.emit('driver-login', data);
  }

  void driverUpdateServer(LatLng location, double heading) {
    Map<String, dynamic> data = {
      'lat': location.latitude,
      'lng': location.longitude,
      'heading': heading,
    };
    _socket.emit('driver-location-update', data);
  }

  void driverIsAccept(int stripId, String status) {
    _socket.emit(
        'driver-response-booking', {'trip_id': stripId, 'status': status});
  }
}

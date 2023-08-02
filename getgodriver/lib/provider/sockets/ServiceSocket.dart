import 'package:flutter/material.dart';
import 'package:getgodriver/configs/api_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

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
        print("connect " + _socket.id.toString());
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

  void userFindTrip(Map<String, dynamic> data) {
    _socket.emit('user-find-trip', data);
  }
}

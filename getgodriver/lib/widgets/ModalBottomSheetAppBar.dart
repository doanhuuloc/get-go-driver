import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_switch/flutter_switch.dart';
import '../provider/sockets/ServiceSocket.dart';
import '../provider/driverViewModel.dart';

class ModalBottomSheetAppBar extends StatelessWidget {
  const ModalBottomSheetAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final driver = context.read<DriverViewModel>();
    final themeData = Theme.of(context);
    return Wrap(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                SizedBox(width: 10),
                Text(
                  "Cài đặt nhận chuyến",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.close,
                color: Colors.black,
              ),
            )
          ],
        ),
        const Divider(height: 2),
        const SizedBox(height: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(
                  Icons.power_settings_new,
                  color: driver.status != "offline" ? Colors.green : Colors.red,
                ),
                const SizedBox(width: 10),
                Text(driver.status != "offline" ? "Trực tuyến" : "Ngoại tuyến"),
              ]),
              FlutterSwitch(
                  height: 30,
                  width: 50,
                  activeColor: Colors.green,
                  activeIcon:
                      const Icon(Icons.power_settings_new, color: Colors.green),
                  inactiveIcon:
                      const Icon(Icons.power_settings_new, color: Colors.red),
                  inactiveColor: Colors.red,
                  value: driver.status != "offline" ? true : false,
                  onToggle: ((value) {
                    if (value) {
                      print('cout<< hêl');
                      driver.updateStatus("waiting");
                      SocketService.connectserver(context);
                    } else {
                      driver.updateStatus("offline");
                      SocketService.disconnect();
                    }
                  })),
            ],
          ),
        ),
        const SizedBox(height: 60)
      ],
    );
  }
}

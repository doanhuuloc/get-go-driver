import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:provider/provider.dart';

class AppBarSetting extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSetting({super.key, required this.isOnline, required this.title});
  final bool isOnline;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final DriverViewModel driver = context.read<DriverViewModel>();
    final SocketService socket = context.read<SocketService>();

    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title),
      backgroundColor: Colors.white,
      actions: [
        Selector<DriverViewModel, String>(
            selector: (p0, p1) => driver.status,
            builder: (context, value, child) {
              return Container(
                width: 180,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Selector<DriverViewModel, String>(
                            selector: (p0, p1) => driver.status,
                            builder: (context, value, child) {
                              return Wrap(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IsOnlineText(
                                          isOnline: driver.status != "offline"
                                              ? true
                                              : false),
                                      IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(Icons.close),
                                      )
                                    ],
                                  ),
                                  const Divider(height: 2),
                                  const SizedBox(height: 10),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Icon(
                                            Icons.power_settings_new,
                                            color: driver.status != "offline"
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(driver.status != "offline"
                                              ? "Trực tuyến"
                                              : "Ngoại tuyến"),
                                        ]),
                                        FlutterSwitch(
                                            height: 30,
                                            width: 50,
                                            activeColor: Colors.green,
                                            activeIcon: Icon(
                                                Icons.power_settings_new,
                                                color: Colors.green),
                                            inactiveIcon: Icon(
                                                Icons.power_settings_new,
                                                color: Colors.red),
                                            inactiveColor: Colors.red,
                                            value: driver.status != "offline"
                                                ? true
                                                : false,
                                            onToggle: ((value) {
                                              if (value) {
                                                print('hêl');
                                                driver.updateStatus("waiting");
                                                socket.connectserver(context);
                                              } else {
                                                driver.updateStatus("offline");
                                                socket.disconnect();
                                              }
                                            })),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 60)
                                ],
                              );
                            });
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IsOnlineText(
                          isOnline: driver.status != "offline" ? true : false),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }
}

class IsOnlineText extends StatelessWidget {
  const IsOnlineText({super.key, required this.isOnline});
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Icon(
          Icons.circle,
          color: isOnline ? Colors.green : Colors.red,
          size: 15,
        ),
        const SizedBox(width: 10),
        Text(
          isOnline ? "Trực tuyến" : "Ngoại tuyến",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

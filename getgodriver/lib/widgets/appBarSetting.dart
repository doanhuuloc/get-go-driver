import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/widgets/ModalBottomSheetAppBar.dart';
import 'package:provider/provider.dart';

class AppBarSetting extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSetting({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    final DriverViewModel driver = context.read<DriverViewModel>();
    // final SocketService socket = context.read<SocketService>();
    final themeData = Theme.of(context);
    return AppBar(
      // iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      actions: [
        Selector<DriverViewModel, String>(
            selector: (p0, p1) => driver.status,
            builder: (context, value, child) {
              return Container(
                // width: 180,
                alignment: Alignment.center,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: themeData.primaryColor,
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
                            return const ModalBottomSheetAppBar();
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IsOnlineText(
                          isOnline: driver.status != "offline" ? true : false),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
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
          size: 10,
        ),
        const SizedBox(width: 15),
        Text(
          isOnline ? "Trực tuyến" : "Ngoại tuyến",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

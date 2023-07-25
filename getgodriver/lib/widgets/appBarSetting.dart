import 'package:flutter/material.dart';

class AppBarSetting extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSetting({super.key, required this.isOnline, required this.title});
  final bool isOnline;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title),
      backgroundColor: Colors.white,
      actions: [
        Container(
          width: 180,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
          ),
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Wrap(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IsOnlineText(isOnline: isOnline),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      const Divider(height: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            Icon(
                              Icons.power_settings_new,
                              color: isOnline ? Colors.green : Colors.red,
                            ),
                            Text(isOnline ? "Trực tuyến" : "Ngoại tuyến"),
                          ]),
                          Switch(
                            value: isOnline,
                            onChanged: (value) {},
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IsOnlineText(isOnline: isOnline),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 15,
                )
              ],
            ),
          ),
        )
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

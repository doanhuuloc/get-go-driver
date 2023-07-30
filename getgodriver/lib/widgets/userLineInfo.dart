import 'package:flutter/material.dart';

class UserLineInfo extends StatelessWidget {
  const UserLineInfo({super.key, required this.title, required this.info});
  final String title;
  final String info;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Text(
                      title,
                      style: themeData.textTheme.titleMedium,
                    ),
                  ),
                  Flexible(
                    child: SizedBox(
                      width: (MediaQuery.of(context).size.width - 20 * 2) * 0.7,
                      child: Text(
                        info,
                        style: themeData.textTheme.bodyMedium,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: 5),
              //   decoration: const BoxDecoration(color: Colors.black54),
              //   height: 1,
              // ),
              const SizedBox(height: 5),
              const Divider(height: 1, color: Colors.black54)
            ],
          ),
        )
      ]),
    );
  }
}

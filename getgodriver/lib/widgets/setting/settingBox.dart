import 'package:flutter/material.dart';

class SettingBox extends StatelessWidget {
  const SettingBox(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.img});
  final String title;
  final String subtitle;
  final String img;
  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  padding: const EdgeInsets.all(10),
                  width: (MediaQuery.of(context).size.width - 20 * 2) * 0.2,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Image(
                    image: AssetImage(img),
                  )),
              Container(
                margin: const EdgeInsets.only(left: 5),
                width: (MediaQuery.of(context).size.width - 20 * 2) * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: themedata.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    subtitle != ""
                        ? Text(
                            subtitle,
                            style: themedata.textTheme.titleSmall,
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.only(right: 10),
              width: (MediaQuery.of(context).size.width - 20 * 2) * 0.1,
              child: Icon(
                Icons.arrow_forward_ios,
                color: themedata.primaryColor,
              ))
        ],
      ),
    );
  }
}

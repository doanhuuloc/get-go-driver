import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.avatar,
    required this.name,
    required this.phone,
    required this.rate,
  });
  final String avatar;
  final String name;
  final String phone;
  final double rate;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/imgs/avatar.jpg"),
              maxRadius: 50,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Evee",
                ),
                Text("0909100509"),
                Container(
                  child: FlutterRating(
                    rating: 3.7,
                    size: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          iconSize: 30,
          icon: Icon(
            Icons.chat,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

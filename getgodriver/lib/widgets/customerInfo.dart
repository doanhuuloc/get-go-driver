import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({
    super.key,
    required this.avatar,
    required this.name,
    required this.phone,
  });
  final String avatar;
  final String name;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(avatar),
          maxRadius: 40,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
            SizedBox(height: 5),
            Text(phone),
          ],
        ),
      ],
    );
  }
}

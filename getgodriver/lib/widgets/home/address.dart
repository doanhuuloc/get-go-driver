import 'package:flutter/material.dart';

class Address extends StatelessWidget {
  Address({super.key, required this.address, this.color = Colors.black});
  final String address;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 24,
          color: color,
        ),
        Flexible(
          child: Text(
            overflow: TextOverflow.clip,
            address,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

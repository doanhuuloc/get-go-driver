import 'package:flutter/material.dart';

class DistanceCost extends StatelessWidget {
  const DistanceCost({super.key, required this.distance, required this.cost});
  final double distance;
  final double cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: "${distance}km", style: TextStyle(color: Colors.black,fontSize: 20)),
        TextSpan(
            text: "đ${cost}",
            style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20))
      ])),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Address extends StatelessWidget {
  Address({super.key, required this.address, this.color,required this.img});
  final String address;
  Color? color;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          img,
          width: 30,
          height: 30,
          color:color,
        ),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            overflow: TextOverflow.clip,
            address,
          ),
        ),
      ],
    );
  }
}

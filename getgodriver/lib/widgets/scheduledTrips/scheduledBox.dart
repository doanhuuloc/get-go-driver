import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApointmentBox extends StatelessWidget {
  const ApointmentBox({super.key, required this.trip});
  final Map<String, dynamic> trip;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final formatApointmentDate = DateFormat.Hm();
    final TripViewModel tripProvider = context.read<TripViewModel>();

    print("cout << box");

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(trip['user']['name'])),
        const SizedBox(height: 10),
        Column(
          children: [
            Address(
              address: trip['start']['place'],
              img: "assets/svgs/fromaddress.svg",
              color: themeData.primaryColor,
            ),
            const SizedBox(height: 10),
            Address(
                address:trip['end']['place'],
                img: "assets/svgs/toaddress.svg"),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/distance.svg",
                  color: themeData.primaryColor,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(width: 5),
                Text("${2} km")
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/money.svg",
                  width: 25,
                  height: 25,
                  color: themeData.primaryColor,
                ),
                const SizedBox(width: 5),
                Text(
                  tripProvider.formatCurrency(double.parse(trip['price'])),
                  // style: TextStyle(color: themeData.primaryColor),
                )
              ],
            ),
            Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/clock.svg",
                  width: 25,
                  height: 25,
                  color: themeData.primaryColor,
                ),
                const SizedBox(width: 5),
                Text(formatApointmentDate
                    .format(DateTime.parse(trip['schedule_time']).add(const Duration(hours: 8))))
              ],
            ),
          ],
        ),
      ]),
    );
  }
}

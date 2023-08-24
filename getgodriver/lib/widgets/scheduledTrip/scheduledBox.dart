import 'package:flutter/material.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ApointmentBox extends StatelessWidget {
  const ApointmentBox({super.key, required this.trip1});
  final TripModel trip1;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final formatApointmentDate = DateFormat.Hm();
    final TripViewModel trip = context.read<TripViewModel>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomerInfo(
          avatar: trip.avatar,
          name: trip.name,
          phone: trip.phone,
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
                Text("${trip.distance} km")
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
                  trip.formatCurrency(trip.cost),
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
                Text(formatApointmentDate.format(trip.scheduledDate!))
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text("Dịch vụ: ${trip.typeCar}"),
        const SizedBox(height: 5),
        Text("Note: ${trip.note}"),
        const SizedBox(height: 10),
        Column(
          children: [
            Address(
              address: trip.fromAddress.summary,
              img: "assets/svgs/fromaddress.svg",
              color: themeData.primaryColor,
            ),
            const SizedBox(height: 10),
            Address(
                address: trip.toAddress.summary,
                img: "assets/svgs/toaddress.svg"),
          ],
        ),
      ]),
    );
  }
}

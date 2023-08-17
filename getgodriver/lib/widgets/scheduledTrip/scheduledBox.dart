import 'package:flutter/material.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:intl/intl.dart';

class ApointmentBox extends StatelessWidget {
  const ApointmentBox({super.key, required this.trip});
  final TripModel trip;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final formatApointmentDate = DateFormat.Hm();

    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: themeData.primaryColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Stack(children: [
          CustomerInfo(
              avatar: trip.avatar,
              name: trip.name,
              phone: trip.phone,
              ),
          Positioned(
            right: 0,
            top:5,
            child: Column(children: [
              Text(
                "đ${trip.cost}",
                style: TextStyle(color: themeData.primaryColor),
              ),
              Text("${trip.distance} km"),
            ]),
          ),
        ]),
        const SizedBox(height: 5),
        Text("Phương tiện: ${trip.typeCar}"),
        const SizedBox(height: 5),
        Text("Note: ${trip.note}"),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 30 * 2) * 0.8,
              child: Column(
                children: [
                  Address(address: trip.fromAddress.summary,img: "assets/svgs/fromaddress.svg",),
                  const SizedBox(height: 10),
                  Address(
                    address: trip.toAddress.summary,
                    color: Theme.of(context).primaryColor,
                    img: "assets/svgs/toaddress.svg"
                  ),
                ],
              ),
            ),
            Text(
              formatApointmentDate.format(trip.scheduledDate!),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ],
        ),
      ]),
    );
  }
}

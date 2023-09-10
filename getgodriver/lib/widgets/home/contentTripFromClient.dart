import 'package:flutter/material.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/home/distanceCost.dart';
import 'package:provider/provider.dart';
import '../customerInfo.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class ContentTripFromClient extends StatelessWidget {
  const ContentTripFromClient({super.key});

  @override
  Widget build(BuildContext context) {
    final TripViewModel trip = context.read<TripViewModel>();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomerInfo(
              avatar: trip.avatar,
              name: trip.name,
              phone: trip.phone,
            ),
            IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: Icon(
                Icons.chat,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
                onPressed: () async {
                  await FlutterPhoneDirectCaller.callNumber(trip.phone);
                },
                icon: Icon(
                  Icons.phone,
                  color: Theme.of(context).primaryColor,
                ))
          ],
        ),
        const SizedBox(height: 10),
        Text("Note: ${trip.note}"),
        const SizedBox(height: 10),
        Address(
          address: trip.fromAddress.summary,
          img: "assets/svgs/fromaddress.svg",
          color: theme.primaryColor,
        ),
        const SizedBox(height: 15),
        Address(
          address: trip.toAddress.summary,
          img: "assets/svgs/toaddress.svg",
        ),
        const SizedBox(height: 10),
        DistanceCost(
          distance: trip.distance,
          cost: trip.formatCurrency(trip.cost),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

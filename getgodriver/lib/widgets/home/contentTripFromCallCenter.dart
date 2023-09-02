import 'package:flutter/material.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:provider/provider.dart';

class ContentTripFromCallCenter extends StatelessWidget {
  const ContentTripFromCallCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = context.read<TripViewModel>();
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(trip.name),
        const SizedBox(height: 20),
        Text(trip.phone),
        const SizedBox(height: 20),
        Address(
          address: trip.fromAddress.summary,
          img: "assets/svgs/fromaddress.svg",
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

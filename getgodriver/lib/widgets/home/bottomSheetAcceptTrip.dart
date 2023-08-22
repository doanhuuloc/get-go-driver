import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/widgets/home/acceptOrRejectTrip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/home/countDownAnimation.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/home/distanceCost.dart';
import 'package:provider/provider.dart';
import '../../provider/tripViewModel.dart';

class BottomSheetAcceptTrip extends StatefulWidget {
  Map<String, dynamic> stripId;
  BottomSheetAcceptTrip({super.key, required this.stripId});

  @override
  State<BottomSheetAcceptTrip> createState() => _BottomSheetAcceptTripState();
}

class _BottomSheetAcceptTripState extends State<BottomSheetAcceptTrip> {
  int remainingTime = 15;
  late Timer timer;

  accpetTrip() {
    context.read<DriverViewModel>().updateStatus('Confirmed');
    SocketService.driverIsAccept(widget.stripId, "Accept");

    // Navigator.pop(context);
    timer.cancel();
    // Navigator.pop(context);
    Navigator.pop(context);

    // Navigator.of(context).pushReplacementNamed(Routes.trip);
  }

  rejectTrip() {
    SocketService.driverIsAccept(widget.stripId, "Deny");
    Navigator.pop(context);
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
        } else {
          timer.cancel();
          rejectTrip();
        }
      });
    });
  }

  @override
  void initState() {
    startCountdown();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TripViewModel trip = context.read<TripViewModel>();
    final theme = Theme.of(context);
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
                      onPressed: () {},
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
                cost: trip.cost,
              ),
              const SizedBox(height: 10),
              AcceptOrRejectTrip(
                accept: accpetTrip,
                reject: rejectTrip,
              ),
              const SizedBox(height: 50)
            ],
          ),
        )
      ],
    );
  }
}

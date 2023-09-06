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
import 'package:getgodriver/widgets/home/contentTripFromCallCenter.dart';
import 'package:getgodriver/widgets/home/contentTripFromClient.dart';
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
  late final TripViewModel trip;
  int remainingTime = 15;
  late Timer timer;

  accpetTrip() {
    context.read<DriverViewModel>().updateStatus('Confirmed');
    SocketService.driverIsAccept(widget.stripId, "Accept");

    timer.cancel();
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
    TripViewModel trip = context.read<TripViewModel>();
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
    // final theme = Theme.of(context);
    final trip = context.read<TripViewModel>();
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              trip.isCallcenter
                  ? ContentTripFromCallCenter()
                  : ContentTripFromClient(),
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

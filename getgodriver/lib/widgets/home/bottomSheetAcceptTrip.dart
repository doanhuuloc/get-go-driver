import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/widgets/home/acceptOrRejectTrip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/home/countDownAnimation.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/home/distanceCost.dart';

class BottomSheetAcceptTrip extends StatefulWidget {
  const BottomSheetAcceptTrip({super.key});

  @override
  State<BottomSheetAcceptTrip> createState() => _BottomSheetAcceptTripState();
}

class _BottomSheetAcceptTripState extends State<BottomSheetAcceptTrip> {
  int remainingTime = 9;
  late Timer timer;
  final trip = TripModel(
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    rate: 3.7,
    cost: 100000,
    distance: 22.6,
    note: "Chở em gái đi học",
    fromAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
    toAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
    scheduledDate: DateTime.utc(2023, 7, 25, 16, 00),
    paymentMethod: "tiền mặt",
    startDate: DateTime.utc(2023, 7, 25, 16, 00),
    endDate: DateTime.utc(2023, 7, 25, 16, 00),
    setTripDate: DateTime.utc(2023, 7, 25, 16, 00),
  );

  accpetTrip() {}
  rejectTrip() {
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
                      rate: trip.rate),
                  IconButton(
                    onPressed: () {},
                    iconSize: 30,
                    icon: Icon(
                      Icons.chat,
                      color: Theme.of(context).primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Note: ${trip.note}",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Address(address: trip.fromAddress),
              const SizedBox(height: 15),
              Address(
                address: trip.toAddress,
                color: Theme.of(context).primaryColor,
              ),
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

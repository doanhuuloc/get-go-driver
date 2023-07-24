import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'package:getgodriver/widgets/home/acceptOrRejectTrip.dart';
import 'package:getgodriver/widgets/home/address.dart';
import 'package:getgodriver/widgets/home/countDownAnimation.dart';
import 'package:getgodriver/widgets/home/customerInfo.dart';
import 'package:getgodriver/widgets/home/distanceCost.dart';

class BottomSheetAcceptTrip extends StatefulWidget {
  const BottomSheetAcceptTrip({super.key});

  @override
  State<BottomSheetAcceptTrip> createState() => _BottomSheetAcceptTripState();
}

class _BottomSheetAcceptTripState extends State<BottomSheetAcceptTrip> {
  int remainingTime = 9;
  late Timer timer;

  String avatar = "assets/imgs/avatar.jpg";
  String name = "Nguyễn Đăng Mạnh Tú";
  String phone = "0909100509";
  double rate = 3.7;

  String note = "Chở em gái đi học";
  String fromAddress = "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm";
  String toAddress = "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm";

  double distance = 22.6;
  double cost = 100000;

  accpetTrip() {}
  rejectTrip() {
    Navigator.pop(context);
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print(remainingTime);
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomerInfo(avatar: avatar, name: name, phone: phone, rate: rate),
          const SizedBox(height: 10),
          Text(
            "Note: $note",
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Address(address: fromAddress),
          const SizedBox(height: 15),
          Address(
            address: toAddress,
            color: Theme.of(context).primaryColor,
          ),
          DistanceCost(
            distance: distance,
            cost: cost,
          ),
          const SizedBox(height: 10),
          AcceptOrRejectTrip(
            accept: accpetTrip,
            reject: rejectTrip,
          )
        ],
      ),
    );
  }
}

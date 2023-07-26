import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';
import 'package:getgodriver/widgets/home/bottomSheetAcceptTrip.dart';
import 'package:getgodriver/widgets/home/countDownAnimation.dart';
import 'package:getgodriver/widgets/home/timerPainer.dart';
import 'package:getgodriver/widgets/map.dart';
import 'package:flutter_rating_native/flutter_rating_native.dart';
import 'dart:math' as math;
import 'package:getgodriver/widgets/home/floatingButtonMap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool isOnline = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBarSetting(
        //   isOnline: isOnline,
        //   title: "",
        // ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                enableDrag: false,
                isDismissible: false,
                context: context,
                builder: (context) {
                  return BottomSheetAcceptTrip();
                },
              );
            },
            child: const Text("haha"),
          ),
        ),
        floatingActionButton: const FloatingButtonMap(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:getgodriver/widgets/home/timerPainer.dart';

class CountdownAnimation extends StatefulWidget {
  const CountdownAnimation({super.key});

  @override
  State<CountdownAnimation> createState() => _CountdownAnimationState();
}

class _CountdownAnimationState extends State<CountdownAnimation>
    with TickerProviderStateMixin {
  late AnimationController controller;
  String get timerString {
    Duration duration = controller.duration! * controller.value;
    return "${duration.inSeconds}";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    return AspectRatio(
      aspectRatio: 1.0,
      child: Stack(children: [
        Positioned.fill(
            child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return CustomPaint(
              painter: TimerPainer(
                animation: controller,
                backgroundColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            );
          },
        )),
        Container(
            width: 35,
            height: 35,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(100)),
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return Text(timerString);
              },
            )),
      ]),
    );
  }
}

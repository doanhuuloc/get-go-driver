import 'package:flutter/material.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../ButtonSizeL.dart';

class ButtonChangeStatusTrip extends StatelessWidget {
  const ButtonChangeStatusTrip({super.key});

  @override
  Widget build(BuildContext context) {
    SocketService socketProvider = context.read<SocketService>();

    return Column(
      children: [
        Selector<DriverViewModel, String>(
            selector: (context, setting) => setting.status,
            builder: (context, status, child) {
              return status == 'Confirmed'
                  ? ButtonSizeL(
                      name: "Đã đến điểm đón",
                      onTap: () {
                        context.read<DriverViewModel>().updateStatus('pickUp');
                      })
                  : status == 'pickUp'
                      ? SlideAction(
                          borderRadius: 10,
                          height: 55,
                          sliderButtonIconPadding: 10,
                          innerColor: Colors.white,
                          outerColor: Theme.of(context).primaryColor,
                          text: 'Bắt đầu chuyến đi',
                          onSubmit: () {
                            socketProvider.handleTripUpdate(context, 'Driving');
                          },
                        )
                      : SizedBox();
              // : SizedBox();
            }),
        Selector<DriverViewModel, String>(
            selector: (context, setting) => setting.status,
            builder: (context, status, child) {
              return status == 'Driving'
                  ? SlideAction(
                      borderRadius: 10,
                      height: 55,
                      sliderButtonIconPadding: 10,
                      innerColor: Colors.white,
                      outerColor: Theme.of(context).primaryColor,
                      text: 'Đã đến điểm đến',
                      onSubmit: () {
                        socketProvider.handleTripUpdate(context, 'Pay');
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.detailedTrip);
                      },
                    )
                  : SizedBox();
            }),
      ],
    );
  }
}

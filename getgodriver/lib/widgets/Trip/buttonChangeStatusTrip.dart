import 'package:flutter/material.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/dialog.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';
import '../ButtonSizeL.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class ButtonChangeStatusTrip extends StatelessWidget {
  const ButtonChangeStatusTrip({super.key});

  @override
  Widget build(BuildContext context) {
    // SocketService socketProvider = context.read<SocketService>();

    return Column(
      children: [
        Selector<DriverViewModel, String>(
            selector: (context, setting) => setting.status,
            builder: (context, status, child) {
              return status == 'Confirmed'
                  ? ButtonSizeL(
                      name: "Đã đến điểm đón",
                      onTap: () {
                        double result = Geolocator.distanceBetween(
                          context
                              .read<DriverViewModel>()
                              .myLocation
                              .coordinates
                              .latitude,
                          context
                              .read<DriverViewModel>()
                              .myLocation
                              .coordinates
                              .longitude,
                          context
                              .read<TripViewModel>()
                              .fromAddress
                              .coordinates
                              .latitude,
                          context
                              .read<TripViewModel>()
                              .fromAddress
                              .coordinates
                              .longitude,
                        );
                        if (result <= 200)
                          context
                              .read<DriverViewModel>()
                              .updateStatus('pickUp');
                        else
                          DialogMessage.show(context);
                      })
                  : status == 'pickUp'
                      ? SlideAction(
                          borderRadius: 10,
                          height: 55,
                          sliderButtonIconPadding: 10,
                          innerColor: Colors.white,
                          outerColor: Theme.of(context).primaryColor,
                          text: 'Bắt đầu chuyến đi',
                          onSubmit: () async {
                            await SocketService.handleTripUpdate(
                                context, 'Driving');
                            Navigator.of(context)
                                .pushReplacementNamed(Routes.tripDriving);
                          },
                        )
                      : SizedBox();
              // : SizedBox();
            }),
      ],
    );
  }
}

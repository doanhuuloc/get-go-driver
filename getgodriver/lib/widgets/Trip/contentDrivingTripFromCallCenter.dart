import 'package:flutter/material.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
import 'package:getgodriver/widgets/Trip/lineInfo.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ContentDrivingTripFromCallCenter extends StatelessWidget {
  const ContentDrivingTripFromCallCenter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final TripViewModel trip = context.read<TripViewModel>();
    final DriverViewModel driver = context.read<DriverViewModel>();
    return Container(
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.bottomCenter,
      child: Container(
        // height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            color: Colors.white),
        child: Wrap(children: [
          Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: theme.primaryColor,
                          size: 40,
                        ),
                        const SizedBox(width: 5),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Điểm dến",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                overflow: TextOverflow.clip,
                                trip.toAddress.summary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      OpenGoogleMaps.openGoogleMaps(trip.toAddress.coordinates);
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/mapArrow.svg',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              LineInfo(
                title: "Khoảng cách",
                content: "${trip.distance} km",
                img: "assets/svgs/distance.svg",
                colors: theme.primaryColor,
              ),
              const SizedBox(height: 20),
              LineInfo(
                  title: "Tổng tiền thanh toán",
                  content: "${trip.cost}đ",
                  img: 'assets/svgs/money-cash.svg'),
              const SizedBox(height: 20),
              Selector<DriverViewModel, String>(
                selector: (p0, p1) => driver.status,
                builder: (context, value, child) {
                  return driver.status == "pickUp"
                      ? SlideAction(
                          borderRadius: 10,
                          height: 55,
                          sliderButtonIconPadding: 10,
                          innerColor: Colors.white,
                          outerColor: Theme.of(context).primaryColor,
                          text: 'Bắt đầu chuyến đi',
                          onSubmit: () {
                            SocketService.handleTripUpdate(context, 'Driving');
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     Routes.detailedTrip, (route) => false);
                            // Navigator.of(context)
                            //     .pushReplacementNamed(Routes.tripDriving);
                          },
                        )
                      : const SizedBox();
                },
              ),
              Selector<DriverViewModel, String>(
                selector: (p0, p1) => driver.status,
                builder: (context, value, child) {
                  return driver.status == "Driving"
                      ? SlideAction(
                          borderRadius: 10,
                          height: 55,
                          sliderButtonIconPadding: 10,
                          innerColor: Colors.white,
                          outerColor: Theme.of(context).primaryColor,
                          text: 'Đã đến điểm đến',
                          onSubmit: () {
                            SocketService.handleTripUpdate(context, 'Done');
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                Routes.detailedTrip, (route) => false);
                          },
                        )
                      : const SizedBox();
                },
              ),
              const SizedBox(height: 20),
            ],
          )
        ]),
      ),
    );
  }
}

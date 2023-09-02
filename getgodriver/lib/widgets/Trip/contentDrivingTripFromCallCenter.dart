import 'package:flutter/material.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
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
                                "Khoa Học Tự Nhiên",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                overflow: TextOverflow.clip,
                                "227 nguyễn văn cừ, phường 4, quận 5, thành phố Hồ Chí Minh",
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
              SlideAction(
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
              ),
              const SizedBox(height: 20),
            ],
          )
        ]),
      ),
    );
  }
}

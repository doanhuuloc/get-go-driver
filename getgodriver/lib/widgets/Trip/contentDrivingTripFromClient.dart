import 'package:flutter/material.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';

class ContentDrivingTripFromClient extends StatelessWidget {
  const ContentDrivingTripFromClient({super.key});

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Address(
                        address: trip.toAddress.summary,
                        img: 'assets/svgs/toaddress.svg',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        OpenGoogleMaps.openGoogleMaps(context
                            .read<TripViewModel>()
                            .toAddress
                            .coordinates);
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/mapArrow.svg',
                      ),
                    ),
                  ],
                ),
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

import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDrivingScreen extends StatelessWidget {
  const TripDrivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SocketService socketProvider = context.read<SocketService>();
    final TripViewModel trip = context.read<TripViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          GoogleMapBuider(
                  currentLocation: LocationModel(title: '', summary: ''))
              .build(),
          Container(
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
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 2),
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
                            onTap: OpenGoogleMaps.openGoogleMaps,
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
                        socketProvider.handleTripUpdate(context, 'Pay');
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            Routes.detailedTrip, (route) => false);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

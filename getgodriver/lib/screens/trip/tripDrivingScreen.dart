import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).primaryColor,width: 2),
                  color: Colors.white),
              child: Wrap(children: [
                Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Address(
                              address: trip.toAddress.summary,
                              img: 'assets/svgs/toaddress.svg',
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svgs/mapArrow.svg',
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
                        Navigator.of(context)
                            .pushReplacementNamed(Routes.detailedTrip);
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

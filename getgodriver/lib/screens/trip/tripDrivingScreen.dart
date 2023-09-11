import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/Trip/contentDrivingTripFromCallCenter.dart';
import 'package:getgodriver/widgets/Trip/contentDrivingTripFromClient.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class TripDrivingScreen extends StatefulWidget {
  const TripDrivingScreen({super.key});

  @override
  State<TripDrivingScreen> createState() => _TripDrivingScreenState();
}

class _TripDrivingScreenState extends State<TripDrivingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SocketService.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SocketService.updateContext(context);
    // final SocketService socketProvider = context.read<SocketService>();
    print("sao nua v ${context.read<TripViewModel>().toAddress.coordinates}");
    final TripViewModel trip = context.read<TripViewModel>();
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            // color: Colors.red,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 155,
            child: GoogleMapBuider(
                    currentLocation: context.read<DriverViewModel>().myLocation)
                .updateIconCurrent("assets/imgs/CarMap.png")
                .setDesLocation(context.read<TripViewModel>().toAddress)
                .setPolyline(context.read<TripViewModel>().direction)
                .build(),
          ),
          trip.isCallcenter
              ? ContentDrivingTripFromCallCenter()
              : ContentDrivingTripFromClient(),
        ],
      ),
    );
  }
}

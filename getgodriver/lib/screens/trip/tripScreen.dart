import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/Trip/collapsedTrip.dart';
import 'package:getgodriver/widgets/Trip/collapsedTripWithCallCenter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../widgets/Trip/slidingTrip.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  @override
  void initState() {
    SocketService.updateContext(context);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height * 0.97,
          minHeight: 240,//270
          renderPanelSheet: false,
          // isDraggable: !trip.isCallCenter,
          collapsed: CollapsedTripWithCallCenter(), //CollapsedTrip(),
          panel: SlidingTrip(),
          body: Scaffold(
            // body: GoogleMapBuider(
            //         currentLocation: LocationModel(title: '', summary: ''),)
            //     .build(),
            // body: Selector<TripViewModel, List<PointLatLng>>(
            //     selector: (context, setting) => setting.direction,
            //     builder: (context, polylinePoints, child) {
            //       return GoogleMapBuider(
            //               currentLocation: LocationModel(title: '', summary: ''))
            //           .updateIconCurrent("assets/svgs/CarMap.svg")
            //           .setDesLocation(context.read<TripViewModel>().fromAddress)
            //           .setPolyline(polylinePoints)
            //           .build();
            //     }),
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
                  bottom: 270,
                  child: GoogleMapBuider(
                          currentLocation:
                              context.read<DriverViewModel>().myLocation)
                      .updateIconCurrent("assets/imgs/CarMap.png")
                      .setDesLocation(context.read<TripViewModel>().fromAddress)
                      .setPolyline(context.read<TripViewModel>().direction)
                      .build(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

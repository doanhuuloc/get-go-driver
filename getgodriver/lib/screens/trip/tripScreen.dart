import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/Trip/collapsedTrip.dart';
import 'package:getgodriver/widgets/Trip/slidingTrip.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  late LocationModel _currentLocation;
  late SocketService socketProvider;
  bool checkArrived = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketProvider = context.read<SocketService>();
  }

  void openGoogleMaps() async {
    String destinationLatitude = "10.7625";
    String destinationLongitude = "106.6823";
    String mapUrl = "geo:$destinationLatitude,$destinationLongitude";
    //  final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${TextStrings.homeLat},${TextStrings.homeLng}";

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Không thể mở Google Maps.";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(),
      body: SlidingUpPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.97,
        minHeight: 270,
        renderPanelSheet: false,
        collapsed: CollapsedTrip(),
        panel: SlidingTrip(),
        body: Scaffold(
          body: GoogleMapBuider(
                  currentLocation: LocationModel(title: '', summary: ''))
              .build(),
        ),
      ),
    );
  }
}

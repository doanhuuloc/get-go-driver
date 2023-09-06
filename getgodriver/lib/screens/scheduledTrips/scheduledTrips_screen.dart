import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/scheduledTrips/changeDate.dart';
import 'package:getgodriver/widgets/scheduledTrips/listAccpetScheduledTrips.dart';
import 'package:getgodriver/widgets/scheduledTrips/listWattingScheduledTrips.dart';
import 'package:getgodriver/widgets/scheduledTrips/scheduledBox.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScheduledTripsScreen extends StatefulWidget {
  const ScheduledTripsScreen({super.key});

  @override
  State<ScheduledTripsScreen> createState() => _ScheduledTripsScreenState();
}

class _ScheduledTripsScreenState extends State<ScheduledTripsScreen> {
  @override
  void initState() {
    super.initState();
    SocketService.updateContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeData.primaryColor,
            title: const Text("Danh sách chuyến đi hẹn giờ"),
          ),
          body: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 0,
              bottom: TabBar(
                indicator: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: themeData.primaryColor,
                    width: 2,
                  ),
                )),
                labelColor: themeData.primaryColor,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(
                      child: const Text(
                    "Danh sách",
                    style: TextStyle(fontSize: 16),
                  )),
                  Tab(
                      child: const Text(
                    "Đã nhận",
                    style: TextStyle(fontSize: 16),
                  )),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                ListWattingScheduledTrips(),
                ListAcceptScheduledTrips(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

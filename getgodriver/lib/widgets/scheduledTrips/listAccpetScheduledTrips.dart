import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/api/api_driver.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/widgets/scheduledTrips/changeDate.dart';
import 'package:getgodriver/widgets/scheduledTrips/scheduledBox.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListAcceptScheduledTrips extends StatefulWidget {
  const ListAcceptScheduledTrips({super.key});

  @override
  State<ListAcceptScheduledTrips> createState() =>
      _ListAcceptScheduledTripsState();
}

class _ListAcceptScheduledTripsState extends State<ListAcceptScheduledTrips> {
  List<dynamic> trips = [];
  final format = DateFormat("dd/MM/yyyy");
  final formatDateApi = DateFormat("dd-MM-yyyy");

  DateTime dateTime = DateTime.now();

  void getListScheduledTrips() async {
    final response = await ApiDriver.getScheduledTrips(
        context.read<DriverViewModel>().driverId);
    print("cout << get api");
    print("cout << $response");
    if (response['statusCode'] == 200) {
      trips = response['trips'];
    } else {
      print("cout<< lấy thông tin tất cả chuyến đi hẹn giờ có vấn đề");
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListScheduledTrips();
  }

  @override
  Widget build(BuildContext context) {
    DateTime checkScheduled = DateTime.now().subtract(const Duration(days: 1));
    final themeData = Theme.of(context);
    // getListScheduledTrips();
    return Column(
      children: [
        Expanded(
          child: !trips.isEmpty
              ? ListView.builder(
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    DateTime schedule_time =
                        DateTime.parse(trips[index]['schedule_time']);
                    return Column(
                      children: [
                        if (format.format(schedule_time) !=
                            format.format(checkScheduled))
                          Container(
                            decoration:
                                BoxDecoration(color: Colors.grey.shade400),
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(left: 10),
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text(format.format(schedule_time),
                                style: themeData.textTheme.bodyLarge),
                          ),
                        Builder(builder: (context) {
                          if (format.format(schedule_time) !=
                              format.format(checkScheduled)) {
                            checkScheduled = schedule_time;
                          }
                          return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    Routes.detailedScheduledTrip,
                                    arguments: trips[index]);
                              },
                              child: ApointmentBox(
                                  trip: trips[index] as Map<String, dynamic>));
                        }),
                      ],
                    );
                  })
              : SvgPicture.asset(
                  "assets/svgs/taxi.svg",
                  height: 100,
                  width: 100,
                ),
        ),
      ],
    );
  }
}

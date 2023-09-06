import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/widgets/scheduledTrips/changeDate.dart';
import 'package:getgodriver/widgets/scheduledTrips/scheduledBox.dart';
import 'package:intl/intl.dart';

class ListWattingScheduledTrips extends StatefulWidget {
  ListWattingScheduledTrips({super.key});

  @override
  State<ListWattingScheduledTrips> createState() =>
      _ListWattingScheduledTripsState();
}

class _ListWattingScheduledTripsState extends State<ListWattingScheduledTrips> {
  List<dynamic> trips = [];
  List<dynamic> currentTrips = [];
  final format = DateFormat("dd/MM/yyyy");
  final formatDateApi = DateFormat("dd-MM-yyyy");

  DateTime dateTime = DateTime.now();

  void change() {
    currentTrips = trips.where((item) {
      DateTime schedule_time = DateTime.parse(item['schedule_time']);
      print(
          "cout << ${format.format(schedule_time)} == ${format.format(dateTime)}");
      return format.format(schedule_time) == format.format(dateTime);
    }).toList();
    print("cout << change");
    print("cout << $trips");

    print("cout << $currentTrips");
    if (mounted) {
      setState(() {});
    }
  }

  void getListScheduledTrips() async {
    final response = await ApiTrip.getScheduledTripsByDate();
    print("cout << get api");
    print("cout << $response");
    if (response['statusCode'] == 200) {
      trips = response['trips'];
      change();
    } else {
      print("cout<< lấy thông tin tất cả chuyến đi hẹn giờ có vấn đề");
    }
    if (mounted) {
      setState(() {});
    }
  }

  backDate() {
    setState(() {
      dateTime = dateTime.subtract(Duration(days: 1));
      change();
    });
  }

  forwardDate() {
    setState(() {
      dateTime = dateTime.add(Duration(days: 1));
      change();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getListScheduledTrips();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // getListScheduledTrips();
    return Column(
      children: [
        ChangeDate(
          dateTime: dateTime,
          backDate: backDate,
          forwardDate: forwardDate,
        ),
        const Divider(height: 1),
        Expanded(
          child: !currentTrips.isEmpty
              ? ListView(
                  children: currentTrips.map((item) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              Routes.detailedScheduledTrip,
                              arguments: item);
                        },
                        child:
                            ApointmentBox(trip: item as Map<String, dynamic>));
                  }).toList(),
                )
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

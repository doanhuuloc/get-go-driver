import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/scheduledTrips/changeDate.dart';
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
  final format = DateFormat("dd/MM/yyyy");
  final formatDateApi = DateFormat("dd-MM-yyyy");
  DateTime dateTime = DateTime.now();
  bool flag = false;

  // late final List<TripModel> trips;
  @override
  void initState() {
    super.initState();
    SocketService.updateContext(context);
    // final response =
    //     await ApiTrip.getScheduledTripsByDate(formatDateApi.format(dateTime));
    // if (response['statusCode'] == 200) {
    //   // trips = response['trips'];
    // } else {
    //   print("cout<< lấy thông tin tất cả chuyến đi hẹn giờ có vấn đề");
    // }
  }

  List<TripModel> apointmentTripList = [
    TripModel(
      id: 1,
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: LocationModel(title: '', summary: ''),
      toAddress: LocationModel(title: '', summary: ''),
      scheduledDate: DateTime.utc(2023, 7, 28, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023, 7, 25, 16, 00),
      endDate: DateTime.utc(2023, 7, 25, 16, 00),
    ),
    TripModel(
      id: 1,
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: LocationModel(title: '', summary: ''),
      toAddress: LocationModel(title: '', summary: ''),
      scheduledDate: DateTime.utc(2023, 8, 17, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023, 7, 25, 16, 00),
      endDate: DateTime.utc(2023, 7, 25, 16, 00),
    ),
    TripModel(
      id: 1,
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: LocationModel(title: '', summary: 'haha'),
      toAddress: LocationModel(title: '', summary: 'haha'),
      scheduledDate: DateTime.utc(2023, 8, 17, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023, 7, 25, 16, 00),
      endDate: DateTime.utc(2023, 7, 25, 16, 00),
    ),
    TripModel(
      id: 1,
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: LocationModel(title: 'ahah', summary: 'haha'),
      toAddress: LocationModel(title: 'haha', summary: 'haha'),
      scheduledDate: DateTime.utc(2023, 8, 26, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023, 7, 25, 16, 00),
      endDate: DateTime.utc(2023, 7, 25, 16, 00),
    ),
  ];

  backDate() {
    setState(() {
      dateTime = dateTime.subtract(Duration(days: 1));
    });
  }

  forwardDate() {
    setState(() {
      dateTime = dateTime.add(Duration(days: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    setState(() {
      flag = false;
    });
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
                Column(
                  children: [
                    ChangeDate(
                      dateTime: dateTime,
                      backDate: backDate,
                      forwardDate: forwardDate,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView(
                        children: apointmentTripList.map((item) {
                          if (format.format(item.scheduledDate!) ==
                              format.format(dateTime)) {
                            setState(() {
                              flag = true;
                            });
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.detailedScheduledTrip,
                                      arguments: item);
                                },
                                child: ApointmentBox(trip1: item));
                          } else {
                            return const SizedBox();
                          }
                        }).toList(),
                      ),
                    ),
                    if (flag == false)
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/svgs/taxi.svg",
                          height: 100,
                          width: 100,
                        ),
                      ),
                  ],
                ),
                Column(
                  children: [
                    ChangeDate(
                      dateTime: dateTime,
                      backDate: backDate,
                      forwardDate: forwardDate,
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: ListView(
                        children: apointmentTripList.map((item) {
                          if (format.format(item.scheduledDate!) ==
                              format.format(dateTime)) {
                            setState(() {
                              flag = true;
                            });
                            return InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.detailedScheduledTrip,
                                      arguments: item);
                                },
                                child: ApointmentBox(trip1: item));
                          } else {
                            return const SizedBox();
                          }
                        }).toList(),
                      ),
                    ),
                    if (flag == false)
                      Expanded(
                        child: SvgPicture.asset(
                          "assets/svgs/taxi.svg",
                          height: 100,
                          width: 100,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/scheduledTrip/scheduledBox.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:intl/intl.dart';

class ScheduledTripsScreen extends StatefulWidget {
  const ScheduledTripsScreen({super.key});

  @override
  State<ScheduledTripsScreen> createState() => _ScheduledTripsScreenState();
}

class _ScheduledTripsScreenState extends State<ScheduledTripsScreen> {
  final format = DateFormat("dd/MM/yyyy");
  DateTime dateTime = DateTime.now();

  List<TripModel> apointmentTripList = [
    TripModel(
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      rate: 3.7,
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      toAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      scheduledDate: DateTime.utc(2023, 7, 28, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023,7,25,16,00),
      endDate: DateTime.utc(2023,7,25,16,00),
    ),
    TripModel(
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      rate: 3.7,
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      toAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      scheduledDate: DateTime.utc(2023, 7, 25, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023,7,25,16,00),
      endDate: DateTime.utc(2023,7,25,16,00),
    ),
    TripModel(
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      rate: 3.7,
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      toAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      scheduledDate: DateTime.utc(2023, 7, 25, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023,7,25,16,00),
      endDate: DateTime.utc(2023,7,25,16,00),
    ),
    TripModel(
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      rate: 3.7,
      cost: 100000,
      distance: 22.6,
      typeCar: "taxi 4 chỗ",
      note: "Chở em gái đi học",
      fromAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      toAddress: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm",
      scheduledDate: DateTime.utc(2023, 7, 26, 16, 00),
      paymentMethod: "tiền mặt",
      startDate: DateTime.utc(2023,7,25,16,00),
      endDate: DateTime.utc(2023,7,25,16,00),
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

    return SafeArea(
      child: Scaffold(
        appBar: const AppBarSetting(
          isOnline: false,
          title: "Chuyến đi hẹn giờ",
        ),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed:
                    format.format(dateTime) == format.format(DateTime.now())
                        ? null
                        : backDate,
                icon: const Icon(Icons.arrow_back_ios),
                disabledColor: Colors.grey,
              ),
              Text(format.format(dateTime)),
              IconButton(
                onPressed: forwardDate,
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              children: apointmentTripList.map((item) {
                if (format.format(item.scheduledDate!) ==
                    format.format(dateTime)) {
                  return ApointmentBox(trip: item);
                } else {
                  return const SizedBox();
                }
              }).toList(),
            ),
          ),
        ]),
      ),
    );
  }
}

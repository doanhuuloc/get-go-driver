import 'package:flutter/material.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';
import 'package:intl/intl.dart';

class DetailedTripScreen extends StatelessWidget {
  const DetailedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    final trip = TripModel(
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
      startDate: DateTime.utc(2023, 7, 25, 16, 00),
      endDate: DateTime.utc(2023, 7, 25, 16, 00),
      setTripDate: DateTime.utc(2023, 7, 25, 16, 00),
    );
    final themedata = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mã chuyến đi : 671893204",
                        style: themedata.textTheme.titleMedium,
                      ),
                      SizedBox(height: 5),
                      Text(format.format(trip.setTripDate!),
                          style: themedata.textTheme.titleSmall)
                    ],
                  ),
                  Image(
                    image: AssetImage("assets/imgs/icontaxi.png"),
                    fit: BoxFit.contain,
                  )
                ],
              ),
            ),
            const Divider(height: 1),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: CustomerInfo(
                  avatar: trip.avatar,
                  name: trip.name,
                  phone: trip.phone,
                  rate: trip.rate),
            ),
            const Divider(height: 1),
            const SizedBox(height: 10),
            UserLineInfo(title: "Loại xe", info: trip.typeCar!),
            UserLineInfo(
                title: "Thời gian hẹn chuyến đi",
                info: format.format(trip.scheduledDate!)),
            UserLineInfo(
                title: "Thời gian đặt chuyến đi",
                info: format.format(trip.startDate)),
            UserLineInfo(
                title: "Thời gian kết thúc chuyến đi",
                info: format.format(trip.endDate)),
            UserLineInfo(title: "Note", info: trip.note),
            UserLineInfo(title: "Lộ trình", info: trip.distance.toString()),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Address(address: trip.fromAddress)),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Address(
                    address: trip.toAddress, color: themedata.primaryColor)),
            UserLineInfo(
                title: "Phương thức thanh toán", info: trip.paymentMethod),
            Container(
              margin: EdgeInsets.only(left: 40, right: 20),
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

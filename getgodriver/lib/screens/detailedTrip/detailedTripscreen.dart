import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/detailedTrip/infoStats.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailedTripScreen extends StatelessWidget {
  const DetailedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("HH:mm dd/MM/yyyy");
    final TripViewModel trip = context.read<TripViewModel>();

    final themedata = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: themedata.primaryColor,
        title: Text(
          "Chi tiết chuyến đi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(
            children: [
              Positioned(
                bottom: 5,
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.centerRight,
                  child: Text(format.format(trip.startDate)),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: CustomerInfo(
                  avatar: trip.avatar,
                  name: trip.name,
                  phone: trip.phone,
                ),
              ),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoStats(title: "Khoảng cách", content: "${trip.distance} km"),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(
                title: "Giá tiền",
                content: trip.formatCurrency(trip.cost),
                color: themedata.primaryColor,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(title: "Dịch vụ", content: trip.typeCar),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(
                address: trip.fromAddress.summary,
                img: "assets/svgs/fromaddress.svg",
                color: themedata.primaryColor,
              )),
          const SizedBox(height: 15),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(
                address: trip.toAddress.summary,
                img: "assets/svgs/toaddress.svg",
              )),
          const SizedBox(height: 15),
          UserLineInfo(
              title: "Phương thức thanh toán", info: trip.paymentMethod),
          UserLineInfo(title: "Lưu ý", info: trip.note),
          const SizedBox(height: 30),
          context.read<DriverViewModel>().status == "Done"
              ? InkWell(
                  onTap: () {
                    // SocketService.handleTripUpdate(context, 'waiting');

                    //         print("hhaa");
                    Navigator.of(context).pushReplacementNamed(Routes.home);
                    // Navigator.of(context)
                    //     .pushNamedAndRemoveUntil(Routes.home, (route) => false);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: themedata.primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      "Hoàn thành chuyến đi",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              : SizedBox(),
        ]),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailedTripScreen extends StatelessWidget {
  const DetailedTripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");
    final TripViewModel trip = context.read<TripViewModel>();

    final themedata = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chi tiết chuyến đi",
          style: TextStyle(color: themedata.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10),
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
          const SizedBox(height: 10),
          const Divider(height: 1, color: Colors.black54),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: CustomerInfo(
              avatar: trip.avatar,
              name: trip.name,
              phone: trip.phone,
            ),
          ),
          const Divider(height: 1, color: Colors.black54),
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
          UserLineInfo(title: "Lộ trình", info: "${trip.distance} km"),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(address: trip.fromAddress.summary,img: "assets/svgs/fromaddress.svg",)),
          const SizedBox(height: 10),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Address(
                  address: trip.toAddress.summary,
                  color: themedata.primaryColor,img: "assets/svgs/toaddress.svg",)),
          UserLineInfo(
              title: "Phương thức thanh toán", info: trip.paymentMethod),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thanh toán cho tài xế",
                    style: themedata.textTheme.titleMedium,
                  ),
                  Text(
                    "${trip.cost}đ",
                    style:
                        TextStyle(fontSize: 16, color: themedata.primaryColor),
                  ),
                ],
              ),
              const Divider(height: 1, color: Colors.black54)
            ]),
          ),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.only(right: 20, left: 30),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cước phí chuyến đi",
                    style: themedata.textTheme.bodySmall,
                  ),
                  Text(
                    "${trip.cost}đ",
                    style: themedata.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Chiết khấu",
                    style: themedata.textTheme.bodySmall,
                  ),
                  Text(
                    "${trip.cost}đ",
                    style: themedata.textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Thuế TNCN",
                  style: themedata.textTheme.bodySmall,
                ),
                Text(
                  "${trip.cost}đ",
                  style: themedata.textTheme.titleSmall,
                ),
              ]),
            ]),
          ),
          context.read<DriverViewModel>().status == "Pay"
              ? InkWell(
                  onTap: () {
                    context
                        .read<SocketService>()
                        .handleTripUpdate(context, 'waiting');
                    Navigator.of(context).pushReplacementNamed(Routes.home);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: themedata.primaryColor,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Hoàn thành chuyến đi",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              : SizedBox(),
        ]),
      ),
    ));
  }
}

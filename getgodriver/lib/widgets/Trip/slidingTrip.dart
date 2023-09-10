import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/ButtonSizeL.dart';
import 'package:getgodriver/widgets/Trip/buttonChangeStatusTrip.dart';
import 'package:getgodriver/widgets/Trip/lineInfo.dart';
import 'package:getgodriver/widgets/Trip/titleInfo.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class SlidingTrip extends StatefulWidget {
  const SlidingTrip({super.key});

  @override
  State<SlidingTrip> createState() => _SlidingTripState();
}

class _SlidingTripState extends State<SlidingTrip> {
  // String status_test = "Confirmed"; // pickUp //Driving

  late SocketService socketProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // socketProvider = context.read<SocketService>();
  }

  @override
  Widget build(BuildContext context) {
    final TripViewModel trip = context.read<TripViewModel>();
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // height: 30,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: theme.primaryColor),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomerInfo(
                      avatar: trip.avatar,
                      name: trip.name,
                      phone: trip.phone,
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 30,
                      icon: Icon(
                        Icons.chat,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await FlutterPhoneDirectCaller.callNumber(trip.phone);
                      },
                      iconSize: 30,
                      icon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              TitleInfo(title: "Lộ trình"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Address(
                  address: trip.fromAddress.summary,
                  img: "assets/svgs/fromaddress.svg",
                  color: theme.primaryColor,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Address(
                  address: trip.toAddress.summary,
                  img: "assets/svgs/toaddress.svg",
                ),
              ),
              const SizedBox(height: 10),
              LineInfo(
                title: "Khoảng cách",
                content: "${trip.distance} km",
                img: "assets/svgs/distance.svg",
                colors: theme.primaryColor,
              ),
              TitleInfo(title: "Note"),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/svgs/note.svg',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      trip.note,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const TitleInfo(title: "Dịch Vụ"),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/svgs/taxi-service.svg',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 10),
                      Text(trip.typeCar, style: TextStyle(fontSize: 18)),
                    ],
                  )),
              const TitleInfo(title: "Thanh toán"),
              LineInfo(
                  title: "Phương thức thanh toán",
                  content: trip.paymentMethod,
                  img: "assets/svgs/payment-method.svg"),
              const SizedBox(height: 10),
              LineInfo(
                  title: "Thanh toán cho tài xế",
                  content: "${trip.cost}đ",
                  img: 'assets/svgs/money-cash.svg'),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Center(
                    child: Text(
                      "Hủy Chuyến",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

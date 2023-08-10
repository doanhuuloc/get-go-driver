import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/trip.dart';
import 'package:getgodriver/widgets/ButtonSizeL.dart';
import 'package:getgodriver/widgets/Trip/buttonChangeStatusTrip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class SlidingTrip extends StatefulWidget {
  const SlidingTrip({super.key});

  @override
  State<SlidingTrip> createState() => _SlidingTripState();
}

class _SlidingTripState extends State<SlidingTrip> {
  // String status_test = "Confirmed"; // pickUp //Driving

  final trip = TripModel(
    id: 1,
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    rate: 3.7,
    cost: 100000,
    distance: 22.6,
    note: "Chở em gái đi học",
    fromAddress: LocationModel(
        title: '', summary: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm"),
    toAddress: LocationModel(
        title: '', summary: "227 Nguyễn Văn Cừ phuong 4 quan 5 tp hcm"),
    scheduledDate: DateTime.utc(2023, 7, 25, 16, 00),
    paymentMethod: "tiền mặt",
    startDate: DateTime.utc(2023, 7, 25, 16, 00),
    endDate: DateTime.utc(2023, 7, 25, 16, 00),
    setTripDate: DateTime.utc(2023, 7, 25, 16, 00),
  );

  late SocketService socketProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    socketProvider = context.read<SocketService>();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<TripViewModel>().status);
    return Container(
      padding: EdgeInsets.all(16),
      // height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 160),
            child: Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
                color: Color(0xFFACAAAA),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomerInfo(
                  avatar: trip.avatar,
                  name: trip.name,
                  phone: trip.phone,
                  rate: trip.rate),
              IconButton(
                onPressed: () {},
                iconSize: 40,
                icon: Icon(
                  Icons.chat,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(color: Colors.black26),
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
          Address(
              address:
                  "77/50/8 Đường Chuyên dùng 9 Phường Phú Mỹ Quận 7 TPHCM"),

          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/svgs/note.svg',
                // width: 13,
                // height: 17.64,
              ),
              const SizedBox(width: 16),
              Text("Chở em gái đi học"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ButtonChangeStatusTrip(),
        ],
      ),
    );
  }
}

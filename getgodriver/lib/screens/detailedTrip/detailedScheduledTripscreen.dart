import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:getgodriver/widgets/detailedTrip/infoStats.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:getgodriver/services/notification.dart' as notify;

class DetailedScheduledTripScreen extends StatefulWidget {
  const DetailedScheduledTripScreen({super.key, required this.trip});

  final Map<String, dynamic> trip;

  @override
  State<DetailedScheduledTripScreen> createState() =>
      _DetailedScheduledTripScreenState();
}

class _DetailedScheduledTripScreenState
    extends State<DetailedScheduledTripScreen> {
  acceptScheduledTrip(String accessToken) async {
    // DateTime sheduledDate =
    //     trip.scheduledDate!.subtract(const Duration(minutes: 15));
    // notify.Notifications()
    //     // .showNotification(
    //     //     "Chuyến đi hẹn giờ bạn đã chấp nhận sẽ bắt đầu vào lúc ${trip.startDate.hour.toString().padLeft(2, '0')} giờ ${trip.startDate.minute.toString().padLeft(2, '0')} phút.");
    //     .showScheduledNotification(
    //         "Chuyến đi hẹn giờ bạn đã chấp nhận sẽ bắt đầu vào lúc ${trip.startDate.hour.toString().padLeft(2, '0')} giờ ${trip.startDate.minute.toString().padLeft(2, '0')} phút.",
    //         sheduledDate);

    final response =
        await ApiTrip.acceptScheduledTrip("${widget.trip['id']}", accessToken);
    if (response['StatusCode'] == 200) {
      print("cout << Nhận chuyến thành công");
    } else {
      print("cout << nhận chuyến thất bại");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("cout << thông tin chi tiết chuyến đi đặt giờ ");
    final tripProvider = context.read<TripViewModel>();
    final driver = context.read<DriverViewModel>();
    final format = DateFormat("HH:mm dd/MM/yyyy");
    final TripViewModel tripView = context.read<TripViewModel>();

    final themedata = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: themedata.primaryColor,
        title: const Text("Chi tiết chuyến đi hẹn giờ"),
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
                  child: Text(format
                      .format(DateTime.parse(widget.trip['schedule_time']))),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
                child: CustomerInfo(
                  avatar: widget.trip['user']['avatar'],
                  name: widget.trip['user']['name'],
                  phone: widget.trip['user']['phone'],
                ),
              ),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InfoStats(title: "Khoảng cách", content: "12 km"),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(
                title: "Giá tiền",
                content:
                    tripView.formatCurrency(double.parse(widget.trip['price'])),
                color: themedata.primaryColor,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: 1,
                decoration: BoxDecoration(color: Colors.black54),
              ),
              InfoStats(title: "Dịch vụ", content: "car"),
            ],
          ),
          const Divider(height: 1, color: Colors.black54),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Address(
              address: widget.trip['start']['place'],
              img: "assets/svgs/fromaddress.svg",
              color: themedata.primaryColor,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Address(
              address: widget.trip['end']['place'],
              img: "assets/svgs/toaddress.svg",
            ),
          ),
          const SizedBox(height: 15),
          UserLineInfo(
              title: "Phương thức thanh toán",
              info: widget.trip['paymentMethod']),
          UserLineInfo(title: "Lưu ý", info: widget.trip['note'].toString()),
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Xác nhận"),
                  content: Text(
                    "Bạn có chấp nhận chuyến đi hẹn giờ vào lúc "
                    // "${trip.scheduledDate!.hour.toString().padLeft(2, '0')} giờ ${trip.scheduledDate!.minute.toString().padLeft(2, '0')} phút, ngày ${trip.scheduledDate!.day} tháng ${trip.scheduledDate!.month} năm ${trip.scheduledDate!.year}"
                    " không?",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        widget.trip['status'] == "Pending"
                            ? acceptScheduledTrip(driver.accessToken)
                            : print("cout << hủy");
                        Navigator.of(context).pop();
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.green),
                        child: const Text(
                          "Chấp nhận",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            color: Colors.red),
                        child: const Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              );
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
                widget.trip['status'] == "Pending"
                    ? "Chấp nhận chuyến đi"
                    : "Hủy chuyến đi",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}

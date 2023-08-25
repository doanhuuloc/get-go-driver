import 'package:flutter/material.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/widgets/appBarSetting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/widgets/setting/settingBox.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool item1 = true;
  void initState() {
    super.initState();
    SocketService.updateContext(context);
  }

  @override
  Widget build(BuildContext context) {
    final driver = context.read<DriverViewModel>();
    List<Map<String, dynamic>> listSetting1 = [
      {
        'title': "Mã QR của tôi",
        'subtitle':
            "Bạn có thể sử dụng mã này tại các sự kiện dành riêng cho các tài xế",
        'img': "assets/imgs/qrcode.png",
        'navigate': Routes.user,
      },
      {
        'title': driver.name,
        'subtitle': "Số điện thoại: ${driver.phone}",
        'img': driver.avatar,
        'navigate': Routes.user,
      },
    ];

    List<Map<String, dynamic>> listSetting2 = [
      {
        'title': "Công đồng tài xế GetGo",
        'subtitle': "",
        'img': "assets/imgs/community.png",
        'navigate': Routes.user,
      },
      {
        'title': "Cài đặt nhận đơn",
        'subtitle': "",
        'img': "assets/imgs/acceptSetting.png",
        'navigate': Routes.user,
      },
      {
        'title': "Bảo hiểm cho đối tác tài xế",
        'subtitle': "",
        'img': "assets/imgs/insurance.png",
        'navigate': Routes.user,
      },
      {
        'title': "Tài khoản thanh toán",
        'subtitle': "",
        'img': "assets/imgs/paymentAccount.png",
        'navigate': Routes.user,
      },
    ];

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...(listSetting1.map((item) => SettingBox(
                  title: item['title'],
                  subtitle: item['subtitle'],
                  img: item['img'],
                  navigate: item['navigate'],
                ))),
            const Image(image: AssetImage("assets/imgs/banner2.png")),
            ...(listSetting2.map((item) => SettingBox(
                  title: item['title'],
                  subtitle: item['subtitle'],
                  img: item['img'],
                  navigate: item['navigate'],
                ))),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "ĐĂNG XUẤT",
                  style: TextStyle(fontSize: 20, color: Colors.red),
                )),
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:getgodriver/models/driverModel.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final user = context.read<DriverViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: themeData.primaryColor,
          title: const Text(
            "Thông tin tài xế",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, themeData.primaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              // color: themeData.primaryColor,
              height: 200,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(user.avatar),
                    radius: 65,
                  ),
                  const SizedBox(height: 5),
                  Text(user.name,
                      style: const TextStyle(fontSize: 24, color: Colors.white))
                ],
              ),
            ),
            const SizedBox(height: 10),
            UserLineInfo(title: "Số điện thoại", info: user.phone),
            UserLineInfo(title: "Email", info: user.email),
            UserLineInfo(title: "Căn cước công dân", info: user.driverLicense),
            UserLineInfo(title: "Giới tính", info: user.gender),
            UserLineInfo(title: "Ngày sinh", info: user.birthDate),
            UserLineInfo(title: "Địa chỉ", info: user.address),
            UserLineInfo(title: "Loại phương tiện", info: user.typeCar),
            UserLineInfo(title: "Biển số xe", info: user.licensePlate),
            UserLineInfo(title: "Mô tả xe", info: user.descriptionCar),
          ]),
        ),
      ),
    );
  }
}

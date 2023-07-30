import 'package:flutter/material.dart';
import 'package:getgodriver/models/userModel.dart';
import 'package:getgodriver/widgets/userLineInfo.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    const user = UserModel(
      avatar: "assets/imgs/avatar.jpg",
      name: "Nguyễn Đăng Mạnh Tú",
      phone: "0909100509",
      email: "tumanh222702@gmail.com",
      id: "875876123",
      gender: "đực",
      birthDate: "??/??/????",
      address: "phú mỹ hưng quận 7",
      typeCar: "xe 4 bánh",
      idCard: "59 - 74A -976237890146",
      descriptionCar:
          "mecedes màu đen có 4 cái cữa, có 4 bánh xe, có 4 chỗ, có tay lái, có phanh xe và có đứa ngáo ngáo tên Tú lái nó",
    );
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
              color: themeData.primaryColor,
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
                  Text(user.name, style: themeData.textTheme.titleLarge)
                ],
              ),
            ),
            const SizedBox(height: 10),
            UserLineInfo(title: "Số điện thoại", info: user.phone),
            UserLineInfo(title: "Email", info: user.email),
            UserLineInfo(title: "Căn cước công dân", info: user.id),
            UserLineInfo(title: "Giới tính", info: user.gender),
            UserLineInfo(title: "Ngày sinh", info: user.birthDate),
            UserLineInfo(title: "Địa chỉ", info: user.address),
            UserLineInfo(title: "Loại phương tiện", info: user.typeCar),
            UserLineInfo(title: "Biển số xe", info: user.idCard),
            UserLineInfo(title: "Mô tả xe", info: user.descriptionCar),
          ]),
        ),
      ),
    );
  }
}

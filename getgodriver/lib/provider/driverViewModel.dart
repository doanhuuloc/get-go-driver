import 'package:flutter/material.dart';
import 'package:getgodriver/models/driverModel.dart';

class DriverViewModel with ChangeNotifier {
  final DriverModel _item = const DriverModel(
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
  
  String _status = "offline";
  String get avatar => _item.avatar;
  String get name => _item.name;
  String get phone => _item.phone;
  String get email => _item.email;
  String get id => _item.id;
  String get gender => _item.gender;
  String get birthDate => _item.birthDate;
  String get address => _item.address;
  String get typeCar => _item.typeCar;
  String get idCard => _item.idCard;
  String get descriptionCar => _item.descriptionCar;
  String get status => _status;

  void updateStatus(String status) {
    _status = status;
    notifyListeners();
  }

}

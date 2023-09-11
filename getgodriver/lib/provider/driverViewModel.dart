import 'package:flutter/material.dart';
import 'package:getgodriver/models/driverModel.dart';
import 'package:getgodriver/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverViewModel with ChangeNotifier {
  final DriverModel _item = DriverModel(
    driverId: 1,
    token:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6OSwicGhvbmUiOiIrODQ5NDE1NDQ1NjkiLCJ0eXBlIjoiRHJpdmVyIiwiaWF0IjoxNjk0MDkzMjM4LCJleHAiOjE2OTUxNzMyMzh9.hBwGYWweCmLkSTAnszsbw8ifJhOr797qgEh2L_kCzrs",
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    email: "tumanh222702@gmail.com",

    // id: "875876123",
    gender: "đực",
    birthDate: "??/??/????",
    address: "phú mỹ hưng quận 7",
    driverLicense: "0964155097",
    licensePlate: "30D-206.32",
    vehicleRegistration: "123456",
    typeCar: "xe 4 bánh",
    // idCard: "59 - 74A -976237890146",
    descriptionCar:
        "mecedes màu đen có 4 cái cữa, có 4 bánh xe, có 4 chỗ, có tay lái, có phanh xe và có đứa ngáo ngáo tên Tú lái nó",
  );
  final LocationModel _myLocation = LocationModel(title: '', summary: '');

  String _status = "offline";
  LocationModel get myLocation => _myLocation;
  int get driverId => _item.driverId;
  String get accessToken => _item.token;
  String get avatar => _item.avatar;
  String get name => _item.name;
  String get phone => _item.phone;
  String get email => _item.email;
  String get gender => _item.gender;
  String get birthDate => _item.birthDate;
  String get address => _item.address;
  String get driverLicense => _item.driverLicense;
  String get licensePlate => _item.licensePlate;
  String get vehicleRegistration => _item.vehicleRegistration;
  String get typeCar => _item.typeCar;
  String get descriptionCar => _item.descriptionCar;
  String get status => _status;

  void updateStatus(String status) {
    _status = status;
    notifyListeners();
  }

  void updateMyLocation(LatLng location, double heading) {
    _myLocation.coordinates = location;
    _myLocation.heading = heading;
    notifyListeners();
  }

  void updateDriverId(int id) {
    _item.driverId = id;
  }

  void updatePhone(String phone) {
    _item.phone = phone;
  }

  void updateAccessToken(String token) {
    _item.token = token;
  }

  void updateDriverInfo(Map<String, dynamic> info) {
    _item.name = info['name'];
    _item.email = info['email'];
    _item.gender = info['gender'];
    // _item.birthDate=info['birthday'];
    // _item.avatar = info['avatar'];
    _item.driverLicense = info['driver_vehicle']['driver_license'];
    _item.vehicleRegistration = info['driver_vehicle']['vehicle_registration'];
    _item.licensePlate = info['driver_vehicle']['license_plate'];
    _item.descriptionCar = info['driver_vehicle']['name'];
    _item.typeCar = info['driver_vehicle']['vehicle_type']['name'];
  }
}

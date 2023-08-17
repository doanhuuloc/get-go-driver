import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';

class TripViewModel with ChangeNotifier {
  TripModel _infoTrip = TripModel(
    id: 1,
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    cost: 100000,
    distance: 22.6,
    typeCar: "taxi 4 chỗ",
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
  set infoTrip(TripModel trip) {
    _infoTrip = trip;
    notifyListeners();
  }

  double get id => _infoTrip.id;
  String get avatar => _infoTrip.avatar;
  String get name => _infoTrip.name;
  String get phone => _infoTrip.phone;

  double get cost => _infoTrip.cost;
  double get distance => _infoTrip.distance;

  String get typeCar => _infoTrip.typeCar;
  String get note => _infoTrip.note;
  LocationModel get fromAddress => _infoTrip.fromAddress;
  LocationModel get toAddress => _infoTrip.toAddress;

  DateTime get startDate => _infoTrip.startDate;
  DateTime get endDate => _infoTrip.endDate;

  String get paymentMethod => _infoTrip.paymentMethod;

  DateTime? get setTripDate => _infoTrip.setTripDate;
  DateTime? get scheduledDate => _infoTrip.scheduledDate;
}

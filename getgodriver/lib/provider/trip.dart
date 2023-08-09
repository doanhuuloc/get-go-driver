import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';

class TripViewModel with ChangeNotifier {
  TripModel _infoTrip = TripModel(
    id: 1,
    avatar: "assets/imgs/avatar.jpg",
    name: "Nguyễn Đăng Mạnh Tú",
    phone: "0909100509",
    rate: 3.7,
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
  String _status = '';
  set infoTrip(TripModel trip) {
    _infoTrip = trip;
    notifyListeners();
  }

  double get tripID => _infoTrip.id;
  String get status => _status;
  void updateStatus(String page) {
    print("cout<< " + page);
    _status = page;
    notifyListeners();
  }
}

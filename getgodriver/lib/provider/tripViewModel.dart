import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/models/tripModel.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TripViewModel with ChangeNotifier {
  TripModel _infoTrip = TripModel(
    id: 1,
    avatar: "https://picsum.photos/200/300",
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
    is_scheduled: false,
    is_callCenter: false,
    startDate: DateTime.utc(2023, 7, 25, 16, 00),
    endDate: DateTime.utc(2023, 7, 25, 16, 00),
    setTripDate: DateTime.utc(2023, 7, 25, 16, 00),
  );
  double price1km = 7;
  List<PointLatLng> _direction = [];

  List<PointLatLng> get direction => _direction;
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

  bool get isScheduled => _infoTrip.is_scheduled;
  bool get isCallcenter => _infoTrip.is_callCenter;
  DateTime? get setTripDate => _infoTrip.setTripDate;
  DateTime? get scheduledDate => _infoTrip.scheduledDate;

  String formatCurrency(double cost) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    return currencyFormatter.format(cost);
  }

  Future<bool> updateDirection(List<PointLatLng> data) async {
    _direction = data;
    notifyListeners();
    return true;
  }

  void updateInfoTrip(Map<String, dynamic> data) {
    Map<String, dynamic> trip_infor = data['trip_info'];
    Map<String, dynamic> user_infor = data['user_info'];

    _infoTrip.id = trip_infor['trip_id'] / 1;
    _infoTrip.avatar = user_infor['avatar'];
    _infoTrip.name = user_infor['name'];
    _infoTrip.phone = user_infor['phone'];
    _infoTrip.typeCar = "xe 4 chỗ";
    _infoTrip.cost = trip_infor['price'] / 1;
    _infoTrip.distance = trip_infor['distance'] / 1; // trip_infor['distance'];
    _infoTrip.note = 'note';
    _infoTrip.fromAddress = LocationModel(
        title: '',
        summary: trip_infor['start']['place'],
        coordinates: LatLng(
            trip_infor['start']['lat'] / 1, trip_infor['start']['lng'] / 1));
    _infoTrip.toAddress = LocationModel(
        title: '',
        summary: trip_infor['end']['place'],
        coordinates:
            LatLng(trip_infor['end']['lat'] / 1, trip_infor['end']['lng'] / 1));
    _infoTrip.paymentMethod = 'momo';
    _infoTrip.is_scheduled = trip_infor['is_scheduled'];
    _infoTrip.is_callCenter = trip_infor['is_callcenter'];
    _infoTrip.startDate = DateTime.utc(2023, 7, 25, 16, 00);
    _infoTrip.endDate = DateTime.utc(2023, 7, 25, 16, 00);

    // notifyListeners();
  }


  double updateTrip(double distance) {
    _infoTrip.distance = distance;
    _infoTrip.cost = distance * price1km;
    return _infoTrip.cost;
  }

  void updateInfoCallCenterTrip(Map<String, dynamic> data) {
    Map<String, dynamic> trip_infor = data['trip_info'];
    _infoTrip.phone = data['user_info'];

    _infoTrip.id = trip_infor['trip_id'] / 1;
    // _infoTrip.phone = user_infor['phone'];
    _infoTrip.typeCar = "xe 4 chỗ";
    _infoTrip.fromAddress = LocationModel(
        title: '',
        summary: trip_infor['start']['place'],
        coordinates: LatLng(
            trip_infor['start']['lat'] / 1, trip_infor['start']['lng'] / 1));
    // _infoTrip.toAddress = LocationModel(
    //     title: '',
    //     summary: trip_infor['end']['place'],
    //     coordinates:
    //         LatLng(trip_infor['end']['lat'] / 1, trip_infor['end']['lng'] / 1));
    _infoTrip.paymentMethod = "Cash";
    _infoTrip.is_scheduled = trip_infor['is_scheduled'];
    _infoTrip.is_callCenter = trip_infor['is_callcenter'];
    _infoTrip.startDate = DateTime.utc(2023, 7, 25, 16, 00);
    _infoTrip.endDate = DateTime.utc(2023, 7, 25, 16, 00);

    // notifyListeners();
  }
}

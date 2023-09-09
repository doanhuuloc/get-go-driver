import 'location.dart';

class TripModel {
  double id;
  String avatar;
  String name;
  String phone;

  double cost;
  double distance;

  String typeCar;
  String note;
  LocationModel fromAddress;
  LocationModel toAddress;

  DateTime startDate;
  DateTime endDate;

  String paymentMethod;
  bool is_scheduled;
  bool is_callCenter;
  DateTime? setTripDate;
  DateTime? scheduledDate;
  String userId;
  TripModel({
    required this.id,
    required this.avatar,
    required this.name,
    required this.phone,
    required this.cost,
    required this.distance,
    required this.typeCar,
    required this.note,
    required this.fromAddress,
    required this.toAddress,
    required this.paymentMethod,
    required this.startDate,
    required this.endDate,
    required this.is_scheduled,
    required this.is_callCenter,
    required this.userId,
    this.scheduledDate,
    this.setTripDate,
  });
}

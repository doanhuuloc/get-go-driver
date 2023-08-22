import 'location.dart';

class TripModel {
  final double id;
  final String avatar;
  final String name;
  final String phone;

  final double cost;
  final double distance;

  final String typeCar;
  final String note;
  LocationModel fromAddress;
  LocationModel toAddress;

  final DateTime startDate;
  final DateTime endDate;

  final String paymentMethod;

  DateTime? setTripDate;
  DateTime? scheduledDate;
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
    this.scheduledDate,
    this.setTripDate,
  });
}

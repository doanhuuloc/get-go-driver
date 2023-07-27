class TripModel {
  final String avatar;
  final String name;
  final String phone;
  final double rate;

  final double cost;
  final double distance;

  final String? typeCar;
  final String note;
  final String fromAddress;
  final String toAddress;

  final DateTime startDate;
  final DateTime endDate;

  final String paymentMethod;

  DateTime? setTripDate;
  DateTime? scheduledDate;
  TripModel({
    required this.avatar,
    required this.name,
    required this.phone,
    required this.rate,
    required this.cost,
    required this.distance,
    this.typeCar,
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

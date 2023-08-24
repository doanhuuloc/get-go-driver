class DriverModel {
  int driverId;
  String token;
  String avatar;
  String name;
  String phone;
  String email;
  String gender;
  String birthDate;
  String address;
  String driverLicense;
  String vehicleRegistration;
  String licensePlate;
  String typeCar;
  String descriptionCar;

  DriverModel({
    required this.driverId,
    required this.token,
    required this.avatar,
    required this.name,
    required this.phone,
    required this.email,
    required this.driverLicense,
    required this.licensePlate,
    required this.vehicleRegistration,
    required this.gender,
    required this.birthDate,
    required this.address,
    required this.typeCar,
    required this.descriptionCar,
  });
}

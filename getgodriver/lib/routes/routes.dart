import 'package:flutter/material.dart';
import 'package:getgodriver/main.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:getgodriver/screens/tab_screen.dart';
import 'package:getgodriver/screens/apointmentTrips/apointmentTrips_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Routes {
  static const String home = '/';
  static const String verification = '/verification';
  static const String login = '/login';
  static const String apointmentTrips = '/apointmentTrips';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => TabScreen());
      case verification:
        final String phone = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => VerificationScreen(phone: phone));
      case apointmentTrips:
        return MaterialPageRoute(builder: (_) => ApointmentTripsScreen());
      default:
        return null;
    }
  }
}

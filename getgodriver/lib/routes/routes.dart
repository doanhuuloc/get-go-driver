import 'package:flutter/material.dart';
import 'package:getgodriver/main.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/password/password_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:getgodriver/screens/detailedTrip/detailedScheduledTripscreen.dart';
import 'package:getgodriver/screens/detailedTrip/detailedTripscreen.dart';
import 'package:getgodriver/screens/history/history_screen.dart';
import 'package:getgodriver/screens/setting/settingscreen.dart';
import 'package:getgodriver/screens/tab_screen.dart';
import 'package:getgodriver/screens/scheduledTrips/scheduledTrips_screen.dart';
import 'package:getgodriver/screens/trip/tripDrivingScreen.dart';
import 'package:getgodriver/screens/user/userScreen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../screens/trip/tripScreen.dart';

class Routes {
  static const String home = '/';
  static const String verification = '/verification';
  static const String password = '/password';
  static const String login = '/login';
  static const String scheduledTrips = '/scheduledTrips';
  static const String detailedScheduledTrip = 'detailedScheduledTrip';
  static const String setting = '/setting';
  static const String user = '/user';
  static const String history = '/history';
  static const String trip = '/trip';
  static const String tripDriving = '/tripDriving';
  static const String detailedTrip = '/detailedTrip';

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
      case password:
        final String phone = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => PasswordScreen(phone: phone));
      case scheduledTrips:
        return MaterialPageRoute(builder: (_) => ScheduledTripsScreen());
      case detailedScheduledTrip:
        return MaterialPageRoute(builder: (_) => DetailedScheduledTripScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case user:
        return MaterialPageRoute(builder: (_) => UserScreen());
      case history:
        return MaterialPageRoute(builder: (_) => HistoryScreen());
      case trip:
        return MaterialPageRoute(builder: (_) => const TripScreen());
      case tripDriving:
        return MaterialPageRoute(builder: (_) => TripDrivingScreen());
      case detailedTrip:
        return MaterialPageRoute(builder: (_) => DetailedTripScreen());
      default:
        return null;
    }
  }
}

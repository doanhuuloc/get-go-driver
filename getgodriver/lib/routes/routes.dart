import 'package:flutter/material.dart';
import 'package:getgodriver/main.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:getgodriver/screens/setting/settingscreen.dart';
import 'package:getgodriver/screens/tab_screen.dart';
import 'package:getgodriver/screens/scheduledTrips/scheduledTrips_screen.dart';
import 'package:getgodriver/screens/user/userScreen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Routes {
  static const String home = '/';
  static const String verification = '/verification';
  static const String login = '/login';
  static const String scheduledTrips = '/scheduledTrips';
  static const String setting = '/setting';
  static const String user = '/user';

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
      case scheduledTrips:
        return MaterialPageRoute(builder: (_) => ScheduledTripsScreen());
      case setting:
        return MaterialPageRoute(builder: (_) => SettingScreen());
      case user:
        return MaterialPageRoute(builder: (_) => UserScreen());
      default:
        return null;
    }
  }
}

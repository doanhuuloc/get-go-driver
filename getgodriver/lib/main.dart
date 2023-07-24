import 'package:flutter/material.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFA8D1D),
      ),
      title: "GetGoDriver",
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generateRoute,
      // home: Scaffold(body: Text("hello")),
    );
  }
}

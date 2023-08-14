import 'package:flutter/material.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/trip.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SocketService(),
        ),
        ChangeNotifierProvider.value(
          value: TripViewModel(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xFFFA8D1D),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 20),
            bodyMedium: TextStyle(fontSize: 16),
            bodySmall: TextStyle(fontSize: 14),
            titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        title: "GetGoDriver",
        initialRoute: Routes.arrived,
        onGenerateRoute: Routes.generateRoute,
        // home: Scaffold(body: Text("hello")),
      ),
    );
  }
}

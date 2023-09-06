import 'package:flutter/material.dart';
import 'package:getgodriver/utils/firebase_options.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/Routes.dart';
import 'package:getgodriver/screens/auth/login/login_screen.dart';
import 'package:getgodriver/screens/auth/verification/verification_screen.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:timezone/data/latest.dart' as tzl;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, name: "taxi_getgo");

  tzl.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Ho_Chi_Minh'));
  runApp(const MyApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // FlutterLocalNotificationsPlugin fltNotification;
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  late final FirebaseMessaging _messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerNotification();
  }

  @override
  Widget build(BuildContext context) {
    // SocketService.updateContext(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: DriverViewModel(),
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
          tabBarTheme: TabBarTheme(
              labelColor: Colors.pink[800],
              labelStyle: TextStyle(color: Colors.pink[800]), // color for text
              indicator: UnderlineTabIndicator(
                  // color for indicator (underline)
                  borderSide: BorderSide(color: Colors.black))),
        ),
        title: "GetGoDriver",
        initialRoute: Routes.home,
        onGenerateRoute: Routes.generateRoute,
        // home: Scaffold(body: Text("hello")),
      ),
    );
  }

  void registerNotification() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    String? token = await _messaging.getToken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
      var initiizationSettingsAndroid =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var iosInit = const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );
      var initializationSettings = InitializationSettings(
          android: initiizationSettingsAndroid, iOS: iosInit);

      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) {
          switch (notificationResponse.notificationResponseType) {
            case NotificationResponseType.selectedNotification:
              // selectNotification(notificationResponse.id.toString());
              break;
            case NotificationResponseType.selectedNotificationAction:
              // if (notificationResponse.actionId == navigationActionId) {
              //   selectNotificationStream.add(notificationResponse.payload);
              // }
              break;
          }
        },
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        var data = message.data;

        // AndroidNotification? android = message.notification?.android;
        if (notification != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              const NotificationDetails(
                  iOS: DarwinNotificationDetails(
                    presentAlert: true,
                    presentBadge: true,
                    presentSound: true,
                  ),
                  android: AndroidNotificationDetails('1', 'pushnotification',
                      channelDescription: 'Test',
                      color: Color(0xffff9d89),
                      colorized: true,
                      priority: Priority.max,
                      channelShowBadge: true,
                      importance: Importance.high,
                      playSound: true)));
        }
      });
    }
  }

  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    // String token = FirebaseMessaging.instance.getToken();
    print(token);
    return token;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String content) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1', 'pushnotification', // Thay 'Channel name' bằng tên của channel
      channelDescription:
          "Your description", // Thay 'Channel description' bằng mô tả của channel
      importance: Importance.max,
      priority: Priority.high, playSound: true,
    );

    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Pomodoro',
      content, 
      platformChannelSpecifics,
      payload: 'item x', 
    );
  }
}

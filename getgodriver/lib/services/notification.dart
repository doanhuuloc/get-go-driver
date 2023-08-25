import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showNotification(String content) async {
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1', 'pushnotification', // Thay 'Channel name' bằng tên của channel
      channelDescription:
          "Your description", // Thay 'Channel description' bằng mô tả của channel
      importance: Importance.max,
      priority: Priority.high, playSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      'Get Go Driver',
      content,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  Future<void> showScheduledNotification(
      String content, DateTime sheduledDate) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1', 'pushnotification', // Thay 'Channel name' bằng tên của channel
      channelDescription:
          "Your description", // Thay 'Channel description' bằng mô tả của channel
      importance: Importance.max,
      priority: Priority.high, playSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: iOSPlatformChannelSpecifics,
    );

    print("cout << sheduledDate is ${sheduledDate}");
    final tz.TZDateTime scheduledTime = tz.TZDateTime(
        tz.local,
        sheduledDate.year,
        sheduledDate.month,
        sheduledDate.day,
        sheduledDate.hour,
        sheduledDate.minute,
        sheduledDate.second);
    print("cout<< cài đặt thông báo");

    // Lên lịch hiển thị thông báo
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Get Go Driver',
      content,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}

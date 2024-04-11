import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  NotificationHelper._();

  static final NotificationHelper notificationHelper = NotificationHelper._();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> showSimpleNotification() async {
    AndroidNotificationDetails android = const AndroidNotificationDetails(
      '1',
      'channel',
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );
    DarwinNotificationDetails iOS = const DarwinNotificationDetails();
    NotificationDetails platform =
        NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Simple Notification',
      'This notification is send by Flutter',
      platform,
      payload: 'Welcome to the Local Notification demo',
    );
  }

  Future<void> scheduleNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '1',
      'channel',
      channelDescription: 'description',
      priority: Priority.high,
      importance: Importance.max,
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics =
        const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Scheduled Notification",
      "This is the Scheduled Notification Body!",
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> showBigPictureNotification() async {
    BigPictureStyleInformation bigPictureStyleInformation =
        const BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      contentTitle: 'flutter devs',
      summaryText: 'summaryText',
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      '1',
      'big text channel name',
      channelDescription: 'big text channel description',
      styleInformation: bigPictureStyleInformation,
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Big Picture Notification',
      'This is the Scheduled Notification Body!',
      platformChannelSpecifics,
      payload: "big image notifications",
    );
  }

  Future<void> showNotificationMediaStyle() async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'media channel id',
      'media channel name',
      channelDescription: 'media channel description',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/ic_launcher"),
      styleInformation: MediaStyleInformation(),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: null);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Media Style Notification',
      'This is the Scheduled Notification Body!',
      platformChannelSpecifics,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notification_demo/helper/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    NotificationHelper.notificationHelper.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings();

    tz.initializeTimeZones();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    NotificationHelper.notificationHelper.flutterLocalNotificationsPlugin
        .initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Simple Notification"),
              content: Text("${response.payload}"),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                await NotificationHelper.notificationHelper
                    .showSimpleNotification();
              },
              child: const Text("Simple Notification"),
            ),
            ElevatedButton(
              onPressed: () async {
                await NotificationHelper.notificationHelper
                    .scheduleNotification();
              },
              child: const Text("Scheduled Notification"),
            ),
            ElevatedButton(
              onPressed: () async {
                await NotificationHelper.notificationHelper
                    .showBigPictureNotification();
              },
              child: const Text("Big Picture Notification"),
            ),
            ElevatedButton(
              onPressed: () async {
                await NotificationHelper.notificationHelper
                    .showNotificationMediaStyle();
              },
              child: const Text("Media Style Notification"),
            ),
          ],
        ),
      ),
    );
  }
}

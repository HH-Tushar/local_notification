
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:timezone/data/latest_all.dart' as tz;


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
class CustomNotification {
  static Future initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = AndroidInitializationSettings('mipmap/ic_launcher');
    // var iOSInitialize =  IOSInitializationSettings();
    var initializationsSettings = InitializationSettings(
      android: androidInitialize,
      //iOS: iOSInitialize
    );
    await flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future showNotification({
    required String title,
    required String body,
    var payload}) async {
    final Int64List VibrationPattern = Int64List(4);
    VibrationPattern[0] = 0;
    VibrationPattern[1] = 1000;
    VibrationPattern[2] = 5000;
    VibrationPattern[3] = 2000;
    AndroidNotificationDetails androidPlatformChannelSpecifics =
     AndroidNotificationDetails(
      "your_channel_id999",
      "name",
      sound: RawResourceAndroidNotificationSound('magic'),
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      channelShowBadge: true,
      enableLights: true,
      audioAttributesUsage: AudioAttributesUsage.notificationRingtone,
      ticker: "ticker",
      enableVibration: true,
      vibrationPattern: VibrationPattern,
    );

    var notificationDetails = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      // iOS: IOSNotificationDetails()
    );
    await flutterLocalNotificationsPlugin.show(221, title, body, notificationDetails);
  }



 static Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
  }



  static Future show()async{
    print("bangla");
    configureLocalTimeZone();
 print("${tz.TZDateTime.now(tz.local)}");

    await flutterLocalNotificationsPlugin.zonedSchedule(
        101,
        'scheduled title',
        'scheduled body',

        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 2)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'chanel_id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);

  }
  static Future scheduledNotification()async{
    final Int64List VibrationPattern = Int64List(4);
    VibrationPattern[0] = 0;
    VibrationPattern[1] = 1000;
    VibrationPattern[2] = 5000;
    VibrationPattern[3] = 2000;

    print("bangla");
    configureLocalTimeZone();
 print("${tz.TZDateTime.now(tz.local)}");

    await flutterLocalNotificationsPlugin.periodicallyShow(
        101,
        'scheduled title',
        'scheduled body',
       RepeatInterval.values[DateTime.sunday],
         NotificationDetails(
            android: AndroidNotificationDetails(
                'chanel_id', 'your channel name',
                channelDescription: 'your channel description',
            vibrationPattern:VibrationPattern,
            )),
        androidAllowWhileIdle: true,);

  }

}

tz.TZDateTime _nextInstanceOfTenAMLastYear() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 10);
}

tz.TZDateTime _nextInstanceOfMondayTenAM() {
  tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
  while (scheduledDate.weekday != DateTime.monday) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

tz.TZDateTime _nextInstanceOfTenAM() {
  final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  tz.TZDateTime scheduledDate =
  tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}

//need to look for this
Future<void> _showNotificationCustomVibrationIconLed() async {
  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;

  final AndroidNotificationDetails androidNotificationDetails =
  AndroidNotificationDetails(
      'other custom channel id', 'other custom channel name',
      channelDescription: 'other custom channel description',
      icon: 'secondary_icon',
      largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500);

  final NotificationDetails notificationDetails =
  NotificationDetails(android: androidNotificationDetails);
  await flutterLocalNotificationsPlugin.show(
      8,
      'title of notification with custom vibration pattern, LED and icon',
      'body of notification with custom vibration pattern, LED and icon',
      notificationDetails);
}
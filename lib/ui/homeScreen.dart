import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CustomNotification.initialize(flutterLocalNotificationsPlugin);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  CustomNotification.showNotification(
                      title: "push",
                      body: "my body le le");
                },
                child: Text("Push Notification")),
            TextButton(
                onPressed: () {
                  CustomNotification.show();
                },
                child: Text("Schedule Notification")),
            TextButton(onPressed: () {
              CustomNotification.show();
              print("tapped on me");
            }, child: Text("Stop Notification")),
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = "/notification-screen";

  @override
  Widget build(BuildContext context) {
    // get the notification message and display on screen
    final message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    // final notification = message.notification;
    // final data = message.data;

    return Scaffold(
      appBar: AppBar(
        title: Text("NotificationPage"),
      ),
      body: Center( 
        child: Column(
          children: [
              Text(message.notification!.title.toString()),
              Text(message.notification!.body.toString()),
              Text(message.data.toString()),
          ],
        ),
      ),
    );
  }
}
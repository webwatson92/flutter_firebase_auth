import 'package:auth/api/FirebaseApi.dart';
import 'package:auth/screens/SignUpScreen.dart';
import 'package:auth/screens/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Push Notification",
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: SignUpScreen(),
      onGenerateRoute: (settings) {
        if (settings.name == NotificationScreen.route) {
          final RemoteMessage? message = settings.arguments as RemoteMessage?;
          return MaterialPageRoute(
            builder: (context) => NotificationScreen(),
          );
        }
        // Gérer d'autres routes si nécessaire
        return null;
      },
    );
  }
}

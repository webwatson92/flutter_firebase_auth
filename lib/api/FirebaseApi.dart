import 'package:auth/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{
  //create an instance of firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notifications
  Future<void> initNotification() async {
    //request permission from user {will prompt user}
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token (normaly you would send this to your server)
    print('Token+++++++++++++++++++++++: $fCMToken');   

    //initialize further settings for push notification
    initPushNotifications();
  }

  //function to handle received messages
  void handleMessage(RemoteMessage? message){
    //if the message is null, do nothin
    if(message == null) return;

    //navigate to new screen when message is receive and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }


  //function to initialize foreground and background settings
  Future initPushNotifications() async{
    //handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
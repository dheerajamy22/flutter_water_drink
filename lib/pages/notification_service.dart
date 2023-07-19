 import 'package:firebase_messaging/firebase_messaging.dart';
 import 'package:shared_preferences/shared_preferences.dart';

 Future<void> handleBackgroundMessage(RemoteMessage message)async{
  print('Title:${message.notification?.title}');
  print('Body:${message.notification?.body}');
  print('Payload:${message.data}');

 }

 class firebaseApi{
  final _firebaseMessaging=FirebaseMessaging.instance;
    
  Future <void> initNotification() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    final FCMToken=await _firebaseMessaging.getToken();
    print("token: $FCMToken");
    pref.setString('device_token', FCMToken as String);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
 }



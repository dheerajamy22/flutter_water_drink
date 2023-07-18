// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> initialNotification() async {
//     const AndroidInitializationSettings initialSettingAndroid = AndroidInitializationSettings('ic_launcher');
//     const InitializationSettings initializationSettings = InitializationSettings(android: initialSettingAndroid);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

// Future<void> scheduleNotification(String title,String body) async {
//   AndroidNotificationDetails androidNotificationDetails=
//   const AndroidNotificationDetails(
//     "channelId", 
//     "channelName",
//     playSound: true,
//     importance: Importance.max,
//     priority: Priority.max
//     );
//     NotificationDetails notificationDetails=NotificationDetails(
//       android: androidNotificationDetails,
//     );
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0, 
//       title, 
//       body, 
//       RepeatInterval.everyMinute, 
//       notificationDetails);
// }
// }




//   // Future<void> scheduleNotification(String title, String body, Duration duration) async {
//   //   AndroidNotificationDetails androidNotificationDetails = const AndroidNotificationDetails(
//   //     "channelId",
//   //     "channelName",
//   //     playSound: true,
//   //     importance: Importance.max,
//   //     priority: Priority.max,
//   //   );
//   //   NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);

//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //     0,
//   //     title,
//   //     body,
//   //     DateTime.now().add(duration),
//   //     notificationDetails,
//   //     androidAllowWhileIdle: true,
//   //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
//   //     matchDateTimeComponents: DateTimeComponents.time,
//   //   );
//   // }
// //}
 

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



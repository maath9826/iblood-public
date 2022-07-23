import 'dart:convert';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class LocalPushNotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static void initialize() {
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void display(RemoteMessage message) async{
    print('message: $message');
    print('message data: ${message.data}');
    try {
      print("In Notification method");
      // int id = DateTime.now().microsecondsSinceEpoch ~/1000000;
      Random random = Random();
      int id = random.nextInt(1000000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "my_channel",
            "my channel",
            importance: Importance.max,
            priority: Priority.high,
          )
      );
      print("my id is ${id.toString()}");
      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,);
    } on Exception catch (e) {
      print('Error>>>$e');
    }
  }

  static sendNotificationToTopic(String title, String body, String topic) async{

    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id':'1',
      'status':'done',
      'message':'iblood',
    };
    try{
      var response = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),headers: {
        'Content-Type':'application/json',
        'Authorization':'key=AAAAT6mlJF8:APA91bFJI5xt1MPf9tePzxoVfgLZB6L04IEQNoXBXnqhO-pgPVycwQI9vliXqnJazrAed52U7tGSGVkckVJOCBTSr4XYy1mJke8fctvrnJfwzzp-D3dOWBlcISgzyjB8-lBB9XSujv9A',
      },body: jsonEncode({
        'notification': <String,dynamic> {'title': title,'body': body},
        'priority':'high',
        'data':data,
        'to':'/topics/$topic'
      }));
      if(response.statusCode == 200){
        print('notification has been sent');
      }else{
        print('Error');
      }
    }catch (e,s){
      print(e);
      print(s);
    }
  }
}
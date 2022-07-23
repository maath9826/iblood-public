import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:iblood/main_tabs/account_tab/pages/archive_page/archive_page.dart';
import 'package:iblood/main_tabs/blood_bank_donors_tab/pages/client_details_page.dart';

import 'package:iblood/main_tabs/blood_banks_tab/pages/blood_bank_bags_page/blood_bank_page.dart';
import 'package:iblood/main_tabs/account_tab/pages/profile_page/profile_page.dart';
import 'package:iblood/main_tabs/private_tab/pages/private_community_page/tabs/members_tab/pages/add_member.dart';
import 'package:iblood/others/helpers/routes_arguments.dart';
import 'package:iblood/main_tabs/public_tab/public_communities_tab.dart';
import 'package:iblood/pages/login_page.dart';
import 'package:iblood/pages/phone_call_page.dart';
import 'package:iblood/pages/signup_page.dart';
import 'package:iblood/pages/splash_page.dart';
import 'package:iblood/providers/auth_provider.dart';
import 'package:iblood/providers/users_provider.dart';
import 'package:iblood/services/local_push_notification_service.dart';
import 'package:provider/provider.dart';
import 'main_tabs/blood_banks_tab/blood_banks_tab.dart';
import 'main_tabs/main_tabs.dart';
import 'main_tabs/private_tab/pages/private_community_page/tabs/donation_requests_tab/pages/add_donation_request.dart';
import 'main_tabs/private_tab/pages/private_community_page/pages/member_details_page/member_details_page.dart';
import 'main_tabs/private_tab/pages/private_community_page/private_community_page.dart';
import 'main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/pages/add_donor.dart';
import 'main_tabs/private_tab/pages/private_community_page/tabs/donors_tab/pages/donor_details_page.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
    playSound: true,);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up : ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
        name: 'BBSystem',
        options: const FirebaseOptions(
          appId: '1:50248671524:android:2fc748a9919b5995e893b1',
          apiKey: 'AIzaSyB4bx1Reat2ngB11wo__3WqwgMtWhihnZM',
          messagingSenderId: '50248671524',
          projectId: 'bb-system-a4d9b',
        ));
  } catch (e) {
    if (!e.toString().contains('already exists')) {
      rethrow;
    }
  }
  LocalPushNotificationService.initialize();
  FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onMessage.listen((event) {
    LocalPushNotificationService.display(event);
  });

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   var notification = message.notification;
    //   var android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthProvider.userData,
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (ctx, authProvider, _) {
          var primarySwatch = Colors.blue;
          return MaterialApp(
            title: 'iblood',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              canvasColor: CupertinoColors.secondarySystemBackground,
              appBarTheme: AppBarTheme(titleTextStyle: TextStyle(color: primarySwatch, fontSize: 16),),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
            ),
            home: FutureBuilder<bool>(
                future: authProvider.isAuth,
                builder: (ctx, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? const MainTabs()
                        : const LogInPage();
                  } else {
                    return Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(width: double.infinity),
                          CircularProgressIndicator()
                        ],
                      ),
                    );
                  }
                }),
            routes: {
              MainTabs.routeName: (ctx) => const MainTabs(),

              /// blood bank pages
              BloodBankPage.routeName: (ctx) => const BloodBankPage(),

              /// donors pages
              ClientDetailsPage.routeName: (ctx) => const ClientDetailsPage(),

              /// private community pages
              PrivateCommunityPage.routeName: (ctx) =>
                  const PrivateCommunityPage(),
              MemberDetailsPage.routeName: (ctx) => const MemberDetailsPage(),
              DonorDetailsPage.routeName: (ctx) => const DonorDetailsPage(),
              AddDonationRequest.routeName: (ctx) => const AddDonationRequest(),
              AddDonor.routeName: (ctx) => const AddDonor(),
              AddMember.routeName: (ctx) => const AddMember(),

              ///profile pages
              ProfilePage.routeName: (ctx) => const ProfilePage(),
              ArchivePage.routeName: (ctx) => const ArchivePage(),

              ///pages
              PhoneCallPage.routeName: (ctx) => const PhoneCallPage(),
              SignUpPage.routeName: (ctx) => const SignUpPage(),
              LogInPage.routeName: (ctx) => const LogInPage(),
            },
          );
        },
      ),
    );
  }
}

// FutureBuilder(
// future: authProvider.autoLogin(),
// builder: (ctx, snapshot) {
// if(snapshot.hasError){
// if(snapshot.error.runtimeType == TypeError){
// debugPrintStack(stackTrace: (snapshot.error as TypeError).stackTrace,label: snapshot.error.toString());
// }
// else{
// throw snapshot.error!;
// }
// }
// return snapshot.connectionState == ConnectionState.waiting
// ? const SplashPage()
//     : const LogInPage();
// }
//
// ),

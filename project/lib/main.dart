import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/Camera_auth.dart/camer_auth.dart';
import 'package:project/Camera_auth.dart/locator.dart';
import 'package:project/Notify/PermissionNotify.dart';
import 'package:project/Notify/StoreMessages.dart';
import 'package:project/Notify/notify.dart';
import 'package:project/ServerData/DataFromServer(AllPages).dart';
import 'package:project/ServerData/createpage.dart';
import 'package:project/map_realtime/updatemarkers.dart';
import 'package:project/screens/onboarding/onboarding_screen.dart';
import 'package:project/screens/sideMenu/connectHomeScreen&menuBar.dart';
import 'package:project/service/Otp_Hindi.dart/otp.dart';
import 'package:project/service/Otp_Hindi.dart/phonescreen.dart';

// ! for Navigator to PageMessage when Click to Notification Message for (navigation Process)
final navigatorKey = GlobalKey<NavigatorState>();

//!function to listen to background changes
Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print('=================Some notification Received');
    print('=================${message.notification!.title}');
    print('=================${message.notification!.body}');
    print('=================${message.data}');
  }
}

//! this camera for model
List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  //!! To initial firebase
  await Firebase.initializeApp();
  updateLocation('-O-BGCTl_a16N-miSVQA', 'mohammed-ali', 31.161379833333328,
      29.864815, '11 El Aman Street, Qesm Mina El Basal, Alexandria, Egypt');
  // updateLocation('-O-5yD8sYpdK7Je_OD1o', 'woody-allen', 31.161379833333328,
  //     29.864815, '11 El Aman Street, Qesm Mina El Basal, Alexandria, Egypt');
  //! to get token for notification
  PushNotifications.init();
  //! to initial localNotification
  PushNotifications.localNotiInit();
  //! Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  //! to handle foreground Notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in Foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });
  //! for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    // Fluttertoast.showToast(msg: "Lauched in Terminated State");
    Future.delayed(const Duration(seconds: 1), () {
      navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }
  //! this for camera fack esp
  setupLocator();
  //! on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("BackGround Notification Tapped");
      navigatorKey.currentState!.pushNamed('/message', arguments: message);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('===============================User is currently signed out!');
      } else {
        print('------------------------------User is signed in!');
      }
    });
    //! Notification when app is opened (Foreground messages) to start when app start
    super.initState();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home:
          //LocationMapPage(),
          //ChatBot(),
          // LocationMapPage(),
          // Home(),
          OnboardingScreen(),
      //  HomeScreen(),
      // GoogleMapp(),
      routes: {
        'DataFromServer': (context) => const DataFromServer(),
        'CreatePage': (context) => const CreatePage(),
        'phone': (context) => const MyPhone(),
        'otp': (context) => const MyOtp(),
        'home': (context) => const Home_MenuSide(),
        'camera_auth': (context) => const FaceRecognition(),
        'welcomeScreen': (context) => const OnboardingScreen(),
        '/message': (context) => const NotifyMessage(),
        '/storeMessages': (context) => const StoreMessage(), // Add this route
      },
    );
  }
}

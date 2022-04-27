import 'dart:io';
import 'package:flutter/material.dart';
import 'package:krishna_travels/notificationsApi.dart';
import 'package:krishna_travels/signUp.dart';
import 'package:krishna_travels/signin.dart';
import 'package:krishna_travels/splash.dart';
// screens
import 'home.dart';
import 'package:krishna_travels/home.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


// Import the provider plugin
import 'package:provider/provider.dart';
// Import the firebase plugins
import 'package:firebase_core/firebase_core.dart';

import 'notificationservice.dart';



// 1
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("44277ffc-aeaa-4580-869b-fa94ac0f232c");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
    // Will be called whenever a notification is opened/button pressed.
  });

  OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    // Will be called whenever the permission changes
    // (ie. user taps Allow on the permission prompt in iOS)
  });

  OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    // Will be called whenever the subscription changes
    // (ie. user gets registered with OneSignal and gets a user ID)
  });

  OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    // Will be called whenever then user's email subscription changes
    // (ie. OneSignal.setEmail(email) is called and the user gets registered
  });


  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

class MyApp extends StatelessWidget {
  get user => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Om Sri Krishna Travels',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.indigoAccent
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
         // '/auth': (context) => AuthenticationWrapper(),
         '/signin': (context) => SignIn(),
         '/signup': (context) => SignUp(),
          '/notifications': (context) => NotificationManagementPage(),
          '/home': (context) => Home(user: user),
        },
      );
  }
}

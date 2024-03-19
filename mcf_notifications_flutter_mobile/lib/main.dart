import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcf_notifications_flutter_mobile/firebase_api.dart';
import 'package:mcf_notifications_flutter_mobile/notification_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();
//Firebase acct=> v7780

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print('Firebase Initialized Successfully');
  await FirebasaeApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NotificationScreen(),
    );
  }
}

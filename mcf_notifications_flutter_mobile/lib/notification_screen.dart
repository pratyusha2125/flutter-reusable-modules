import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});
  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    //  final message = ModalRoute.of(context)!.settings.arguments
    //  final message = ModalRoute.of(context)!.settings.arguments
    return Scaffold(
      appBar: AppBar(
        title: Text('PushNotifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Motivity Labs'),
          ],
        ),
      ),
    );
  }
}

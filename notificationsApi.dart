import 'package:flutter/material.dart';

import 'notificationApiClass.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'notificationservice.dart';



class NotificationManagementPage extends StatefulWidget {
  @override
  _NotificationManagementPageState createState() => _NotificationManagementPageState();
}

class _NotificationManagementPageState extends State<NotificationManagementPage> {

  TextEditingController _titleTextController = TextEditingController();
  TextEditingController _bodyTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold (appBar: AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      backgroundColor: Colors.indigoAccent,
      title: const Text(
        'Notifications Management',
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    ), body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: false,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Title'),
              controller: _titleTextController),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: TextFormField(
              enableSuggestions: false,
              autocorrect: false,
              obscureText: false,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Body'),
              controller: _bodyTextController),
        ),
        ElevatedButton(
          child: Text(
            'Simple Notification',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            NotificationService().showNotification(1, _titleTextController.text, _bodyTextController.text, 1);
          },
          // =>
            //  NotificationApi.showNotification(
           // title: 'hi santhosh',
           // body: 'go for dinner',
           // payload: 'santhosh.abd',

        ),
        const SizedBox(
          height: 16,
        ),
        GestureDetector(
          onTap: () {
            NotificationService().cancelAllNotifications();
          },
          child: Container(
            height: 40,
            width: 200,
            color: Colors.red,
            child: Center(
              child: Text(
                "Cancel All Notifications",
              ),
            ),
          ),
        ),
      ],
    ),
    ),
    );
  }
}

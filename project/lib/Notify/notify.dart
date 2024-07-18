import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/constants/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifyMessage extends StatefulWidget {
  const NotifyMessage({Key? key});

  @override
  State<NotifyMessage> createState() => _NotifyMessageState();
}

class _NotifyMessageState extends State<NotifyMessage> {
  Map payload = {};

  @override
  void initState() {
    super.initState();
  }

  void _storeMessage(String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> storedMessages = prefs.getStringList('messages') ?? [];
    storedMessages.add(message);
    await prefs.setStringList('messages', storedMessages);
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments;
    if (data is RemoteMessage) {
      payload = data.data;
      _storeMessage(jsonEncode(payload));
    } else if (data is NotificationResponse) {
      payload = jsonDecode(data.payload!);
      _storeMessage(jsonEncode(payload));
    }

    String currentTime = DateTime.now().toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Message'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width *
              0.8, // Adjust the width as needed
          child: Card(
            color: AppColors.WelcomePageBackGround,
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ensure the card shrinks to fit the content
                children: [
                  Text(
                    "${payload.toString()}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Time: $currentTime',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

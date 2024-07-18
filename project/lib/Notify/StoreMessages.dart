import 'package:flutter/material.dart';
import 'package:project/constants/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreMessage extends StatefulWidget {
  const StoreMessage({Key? key}) : super(key: key);

  @override
  _StoreMessageState createState() => _StoreMessageState();
}

class _StoreMessageState extends State<StoreMessage> {
  List<String> storedMessages = [];

  @override
  void initState() {
    super.initState();
    _loadStoredMessages();
  }

  void _loadStoredMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedMessages = prefs.getStringList('messages') ?? [];
    });
  }

  void _deleteMessage(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedMessages.removeAt(index);
      prefs.setStringList('messages', storedMessages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera 1_Notifications',
            style: const TextStyle(
                color: Color.fromARGB(255, 108, 17, 255),
                fontSize: 23,
                fontWeight: FontWeight.bold,
                fontFamily: "NEWS706")),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: storedMessages.length,
          itemBuilder: (context, index) {
            return Card(
              color: AppColors.WelcomePageBackGround,
              elevation: 4,
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storedMessages[index],
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Time : ${DateTime.now().toString()}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        color: const Color.fromARGB(255, 255, 0, 0),
                        onPressed: () {
                          _deleteMessage(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

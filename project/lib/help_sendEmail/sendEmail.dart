// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import Flutter SVG package
import 'package:project/chatboot/chatbot.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:project/constants/Colors.dart';

class SendMyEmail extends StatefulWidget {
  const SendMyEmail({Key? key});
  @override
  State<SendMyEmail> createState() => _SendMyEmailState();
}

class _SendMyEmailState extends State<SendMyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Form'),
        backgroundColor: AppColors.WelcomePageBackGround,
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                'assets/icons/sendMail.svg', // Replace with your asset path
                height: 200, // Adjust the height as needed
                width: 200, // Adjust the width as needed
              ),
            ])),
        const Text("Contact Us 📧",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(
          height: 50,
        ),
        // ElevatedButton.icon(
        //   onPressed: () async {
        //     String? encodeQueryParameters(Map<String, String> params) {
        //       return params.entries
        //           .map((MapEntry<String, String> e) =>
        //               '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        //           .join('&');
        //     }

        //     final Uri emailUri = Uri(
        //       scheme: 'mailto',
        //       path: 'em7753394@gmail.com',
        //       query: encodeQueryParameters(<String, String>{
        //         'subject': 'Solve My Problem',
        //         'body': 'anyyyyyyyyy thinggggggggg'
        //       }),
        //     );
        //     // if (await canLaunch(emailUri.toString())) {
        //     //   await launch(emailUri.toString());
        //     // } else {
        //     //   throw Exception('Could not launch $emailUri');
        //     // }

        //     try {
        //       await launchUrl(emailUri);
        //     } catch (e) {
        //       print(e.toString());
        //     }
        //   },
        //   style: ElevatedButton.styleFrom(
        //       backgroundColor: const Color.fromARGB(255, 255, 152, 166),
        //       minimumSize: const Size(280, 50),
        //       shape: const RoundedRectangleBorder(
        //           borderRadius: BorderRadius.only(
        //         topLeft: Radius.circular(10),
        //         topRight: Radius.circular(25),
        //         bottomRight: Radius.circular(25),
        //         bottomLeft: Radius.circular(25),
        //       ))),
        //   icon: const Icon(CupertinoIcons.arrow_right,
        //       color: AppColors.RawColoronButton),
        //   label: const Text("Send Email"),
        // ),
        // SizedBox(
        //   height: 50,
        // ),
        ElevatedButton.icon(
          onPressed: () async {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatBot()));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 152, 166),
              minimumSize: const Size(280, 50),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ))),
          icon: const Icon(CupertinoIcons.arrow_right,
              color: AppColors.RawColoronButton),
          label: const Text("chat Me"),
        ),
      ]
          // Add other form fields or widgets as needed
          ),
    );
  }
}

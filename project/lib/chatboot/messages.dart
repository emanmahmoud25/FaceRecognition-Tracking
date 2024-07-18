import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/constants/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;

  const MessagesScreen({Key? key, required this.messages}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: widget.messages[index]['isUserMessage']
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(
                        widget.messages[index]['isUserMessage'] ? 0 : 20),
                    topLeft: Radius.circular(
                        widget.messages[index]['isUserMessage'] ? 20 : 0),
                  ),
                  color: widget.messages[index]['isUserMessage']
                      ? Color.fromARGB(255, 255, 178, 188)
                      : AppColors.WelcomePageBackGround.withOpacity(0.8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                constraints: BoxConstraints(maxWidth: w * 2 / 3),
                child: _buildMessageText(
                    widget.messages[index]['message'].text.text[0]),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (_, i) => Padding(padding: EdgeInsets.only(top: 10)),
      itemCount: widget.messages.length,
    );
  }

  Widget _buildMessageText(String text) {
    final RegExp emailRegExp =
        RegExp(r'\b[\w.%-]+@[\w.-]+\.[A-Z]{2,}\b', caseSensitive: false);
    final RegExp phoneRegExp = RegExp(
        r'(\+?\d{1,3})?[\s.-]?\(?\d{1,4}?\)?[\s.-]?\d{1,4}[\s.-]?\d{1,4}[\s.-]?\d{1,9}');
    final RegExp linkRegExp =
        RegExp(r'(?:(?:http|https|ftp)://)?[\w/-?=%.]+\.[\w/-?=%.]+');

    final Iterable<Match> emailMatches = emailRegExp.allMatches(text);
    final Iterable<Match> phoneMatches = phoneRegExp.allMatches(text);
    final Iterable<Match> linkMatches = linkRegExp.allMatches(text);

    if (emailMatches.isEmpty && phoneMatches.isEmpty && linkMatches.isEmpty) {
      return Text(
        text,
        style: TextStyle(
          color: Colors.black, // Set text color to black
          fontWeight: FontWeight.bold, // Set font weight
        ),
      );
    }

    List<TextSpan> spans = [];
    int lastEnd = 0;

    List<Match> allMatches = [];
    allMatches.addAll(emailMatches);
    allMatches.addAll(phoneMatches);
    allMatches.addAll(linkMatches);
    allMatches.sort((a, b) => a.start.compareTo(b.start));

    for (final Match match in allMatches) {
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: TextStyle(
            color: Colors.black, // Set text color to black
            fontWeight: FontWeight.bold,
          ),
        ));
      }
      if (emailRegExp.hasMatch(match.group(0)!)) {
        spans.add(TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchEmail(match.group(0)),
        ));
      } else if (phoneRegExp.hasMatch(match.group(0)!)) {
        spans.add(TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _showPhoneOptions(match.group(0)),
        ));
      } else if (linkRegExp.hasMatch(match.group(0)!)) {
        spans.add(TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () => _launchLink(match.group(0)),
        ));
      }
      lastEnd = match.end;
    }

    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: TextStyle(
          color: Colors.black, // Set text color to black
          fontWeight: FontWeight.bold,
        ),
      ));
    }

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }

  void _launchEmail(String? email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $email';
    }
  }

  void _showPhoneOptions(String? phone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an action'),
          content: Text('Would you like to send an SMS or make a call?'),
          actions: <Widget>[
            TextButton(
              child: Text('SMS'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchSMS(phone);
              },
            ),
            TextButton(
              child: Text('Call'),
              onPressed: () {
                Navigator.of(context).pop();
                _launchCall(phone);
              },
            ),
          ],
        );
      },
    );
  }

  void _launchSMS(String? phone) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phone,
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch SMS to $phone';
    }
  }

  void _launchCall(String? phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch call to $phone';
    }
  }

  void _launchLink(String? link) async {
    final Uri linkUri = Uri.parse(link!);
    if (await canLaunchUrl(linkUri)) {
      await launchUrl(linkUri);
    } else {
      throw 'Could not launch $link';
    }
  }
}

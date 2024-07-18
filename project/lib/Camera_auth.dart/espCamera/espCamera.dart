// import 'dart:async';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class StreamCameraScreen extends StatefulWidget {
//   @override
//   _StreamCameraScreenState createState() => _StreamCameraScreenState();
// }

// class _StreamCameraScreenState extends State<StreamCameraScreen> {
//   late StreamController<Uint8List> _streamController;

//   @override
//   void initState() {
//     super.initState();
//     _streamController = StreamController<Uint8List>();
//     _startStream();
//   }

//   @override
//   void dispose() {
//     _streamController.close();
//     super.dispose();
//   }

//   Future<void> _startStream() async {
//     try {
//       final url =
//           'https://c77a-41-34-162-77.ngrok-free.app/mjpeg/1'; // Replace with your ESP32-CAM's IP address
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         // Stream received successfully
//         _streamController.addStream(Stream.fromIterable([response.bodyBytes]));
//       } else {
//         // Display an alert if the request fails
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Failed to start stream'),
//               content: Text('Status code: ${response.statusCode}'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       // Display an alert for any other errors
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error starting stream'),
//             content: Text('$e'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ESP32-CAM Stream'),
//       ),
//       body: Center(
//         child: StreamBuilder<Uint8List>(
//           stream: _streamController.stream,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Image.memory(snapshot.data!);
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:video_player/video_player.dart';

// class StreamCameraScreen extends StatefulWidget {
//   @override
//   _StreamCameraScreenState createState() => _StreamCameraScreenState();
// }

// class _StreamCameraScreenState extends State<StreamCameraScreen> {
//   late StreamController<Uint8List> _streamController;
//   VideoPlayerController? _videoController;
//   late String _tempFilePath;

//   @override
//   void initState() {
//     super.initState();
//     _streamController = StreamController<Uint8List>();
//     _startStream();
//   }

//   @override
//   void dispose() {
//     _streamController.close();
//     _videoController?.dispose();
//     // Do not delete the temporary file here
//     super.dispose();
//   }

//   Future<void> _startStream() async {
//     try {
//       final url =
//           'https://c77a-41-34-162-77.ngrok-free.app/mjpeg/1'; // Replace with your ESP32-CAM's IP address
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         // Stream received successfully
//         final bytes = response.bodyBytes;
//         // Save bytes to temporary file
//         final tempDir = await getTemporaryDirectory();
//         _tempFilePath = '${tempDir.path}/stream.mp4';
//         final file = File(_tempFilePath);
//         await file.writeAsBytes(bytes);
//         // Initialize VideoPlayerController with the temporary file
//         _videoController = VideoPlayerController.file(file)
//           ..initialize().then((_) {
//             _videoController!.play();
//           });
//         // Update stream controller with received bytes
//         _streamController.addStream(Stream.fromIterable([bytes]));
//       } else {
//         // Handle failure to start stream
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Failed to start stream'),
//               content: Text('Status code: ${response.statusCode}'),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       // Handle other errors
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error starting stream'),
//             content: Text('$e'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ESP32-CAM Stream'),
//       ),
//       body: Center(
//         child: _videoController != null && _videoController!.value.isInitialized
//             ? AspectRatio(
//                 aspectRatio: _videoController!.value.aspectRatio,
//                 child: VideoPlayer(_videoController!),
//               )
//             : CircularProgressIndicator(), // or any other loading indicator
//       ),
//     );
//   }
// }
// importing dependencies
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';

// // function to trigger the build process

// _launchURLBrowser() async {
//   const url = 'https://www.geeksforgeeks.org/';
//   if (await canLaunch(url)) {
//     await launch(url, forceSafariVC: false);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// _launchURLApp() async {
//   const url = 'https://www.geeksforgeeks.org/';
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// class StreamCameraScreen extends StatelessWidget {
//   const StreamCameraScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Geeks for Geeks'),
//           backgroundColor: Colors.green,
//         ),
//         body: SafeArea(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Text(
//                   'Welcome to GFG!',
//                   style: TextStyle(
//                     fontSize: 30.0,
//                     color: Colors.green,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _launchURLBrowser,
//                   child: const Text('Open in Browser'),
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _launchURLApp,
//                   child: const Text('Open in App'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project/constants/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamCameraScreen extends StatelessWidget {
  const StreamCameraScreen({Key? key}) : super(key: key);

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Lottie.asset(
                'assets/Lottie/Animation - 1713429057133.json', // Replace with your asset path
                height: 200, // Adjust the height as needed
                width: 200, // Adjust the width as needed
              ),
            ])),
        const SizedBox(
          height: 30,
        ),
        const Text("Streaming",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 44, 0, 57))),
        // const SizedBox(
        //   height: 50,
        // ),
        Center(
            child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: ElevatedButton.icon(
                  onPressed: () {
                    _launchURL(
                        "https://583f-41-34-175-243.ngrok-free.app/mjpeg/1");
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
                  label: const Text("Camera esp"),
                )))
      ],
    ));
  }
}
        // child: Container(
        //   height: 50,
        //   width: 120,
        //   color: Colors.red,
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         _launchURL("https://www.geeksforgeeks.org/urls-in-flutter/");
        //       },
        //       child: const Text("Launch URL"),
        //     ),
        //   ),
        // ),

 
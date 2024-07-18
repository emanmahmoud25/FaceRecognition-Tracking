// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';

// class MODEL_CAM_GALLERY extends StatefulWidget {
//   MODEL_CAM_GALLERY({super.key});
//   @override
//   State<MODEL_CAM_GALLERY> createState() => _MODEL_CAM_GALLERYState();
// }

// class _MODEL_CAM_GALLERYState extends State<MODEL_CAM_GALLERY>
//     with SingleTickerProviderStateMixin {
//   //!!!!!!!!!!!!!!!!!!!!!!!!!11 for Gallery
//   // bool _loading = true;
//   //late File _image;
//   final imagepicker = ImagePicker();
//   //List _predictions = [];
//   loading_gallery() async {
//     var image = await imagepicker.pickImage(source: ImageSource.gallery);

//     if (image == null) {
//       return null;
//     } else {
//       // setState(() {
//       //   _loading = false;
//       // });
//       //  _image = File(image.path);
//     }
//     // detectimage(_image);
//   }

// //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
// //!!!!!!!!!!!!!!!!!!!!!! for detect image
//   // @override
//   // void initState() {
//   //   super.initState();
//   //loadModel();
//   // }

//   // loadModel() async {
//   //   await Tflite.loadModel(
//   //     model: "assets/model/model_unquant.tflite",
//   //     labels: "assets/model/labels.txt",
//   //   );
//   // }

//   // detectimage(File image) async {
//   //   var prediction = await Tflite.runModelOnImage(
//   //     path: image.path,
//   //     imageMean: 127.5,
//   //     imageStd: 127.5,
//   //     numResults: 2,
//   //     threshold: 0.1,
//   //   );
//   //   setState(() {
//   //     _loading = false;
//   //     _predictions = prediction!;
//   //   });
//   // }
// //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//   // @override
//   // void dispose() {
//   //   _controller.dispose();
//   //   super.dispose();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         // title: Text(
//         //   "Face Recognition From Gallery",
//         //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         // ),
//       ),
//       body: Container(
//         height: h,
//         width: w,
//         // color: const Color.fromARGB(255, 252, 252, 252),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           Container(
//             height: 200,
//             width: 200,
//             // color: Colors.green,
//             padding: EdgeInsets.all(10),
//             child: Lottie.asset(
//               'assets/Lottie/face.json',
//               height: 150,
//             ),
//           ),
//           Container(
//               child: const Text(
//             "Face Recognition",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           )),
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: 350,
//             height: 70,
//             padding: EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () {
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context) => ModelCamera()));
//               },
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 255, 167, 179))),
//               child: const Text(
//                 "Camera",
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//             ),

//             ///
//           ),
//           //! Gallery Button
//           Container(
//             width: 350,
//             height: 70,
//             padding: EdgeInsets.all(10),
//             child: ElevatedButton(
//               onPressed: () {
//                 loading_gallery();
//               },
//               style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all<Color>(
//                       const Color.fromARGB(255, 255, 167, 179))),
//               child: const Text(
//                 "Gallery",
//                 style:
//                     TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//             ),
//             ///////////////////////////////
//             ///
//           ),
//           //!!!!!!!!!!!!!!!!!!!!!!!!!! container for label and confidence
//           // _loading == false
//           // ? Container(
//           //     child: Column(
//           //       children: [
//           //         Container(
//           //           height: 200,
//           //           width: 200,
//           //           child: Image.file(_image),
//           //         ),
//           //         Text(
//           //             "Label: ${_predictions[0]["label"].toString().isNotEmpty ? _predictions[0]["label"] : "unknown"}"),
//           //         Text(
//           //             "Confidence: ${(_predictions[0]["confidence"] * 100).toStringAsFixed(2)}%"),
//           //       ],
//           //     ),
//           //   )
//           // : Container()
//         ]),
//       ),
//     );
//   }
// }

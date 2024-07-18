// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:project/main.dart';
// import 'package:tflite/tflite.dart';

// class ModelCamera extends StatefulWidget {
//   const ModelCamera({Key? key}) : super(key: key);

//   @override
//   State<ModelCamera> createState() => _ModelCameraState();
// }

// class _ModelCameraState extends State<ModelCamera> {
//   CameraImage? cameraImage;
//   CameraController? cameraController;
//   String output = '';
//   bool isInterpreterBusy = false;
//   bool isWidgetMounted = false;

//   @override
//   void initState() {
//     super.initState();
//     isWidgetMounted = true;

//     loadCamera();
//     loadModel();
//   }

//   @override
//   void dispose() {
//     isWidgetMounted = false;
//     // Other disposal code
//     super.dispose();
//   }

//   loadCamera() {
//     cameraController = CameraController(cameras![0], ResolutionPreset.medium);
//     cameraController!.initialize().then((value) {
//       if (!mounted) {
//         return;
//       } else {
//         setState(() {
//           cameraController!.startImageStream((imageStream) {
//             cameraImage = imageStream;
//             runModel();
//           });
//         });
//       }
//     });
//   }

//   runModel() async {
//     if (cameraImage != null && !isInterpreterBusy) {
//       //this for if debug
//       isInterpreterBusy = true;

//       try {
//         var predictions = await Tflite.runModelOnFrame(
//           bytesList: cameraImage!.planes.map((Plane) {
//             return Plane.bytes;
//           }).toList(),
//           imageHeight: cameraImage!.height,
//           imageWidth: cameraImage!.width,
//           imageMean: 127.5,
//           imageStd: 127.5,
//           rotation: 90,
//           numResults: 2,
//           threshold: 0.1,
//           asynch: true,
//         );

//         if (isWidgetMounted) {
//           setState(() {
//             output = getLabel(predictions);
//           });
//         }
//       } finally {
//         isInterpreterBusy = false;
//       }
//     }
//   }

//   String getLabel(List<dynamic>? predictions) {
//     if (predictions != null && predictions.isNotEmpty) {
//       double confidence = predictions[0]['confidence'] * 100;
//       String label = predictions[0]['label'];

//       // Check if the confidence is above a certain threshold
//       if (confidence > 0.0) {
//         return 'Label: $label\nConfidence: ${confidence.toStringAsFixed(2)}%';
//       } else {
//         // If confidence is too low, consider it as unknown
//         return 'Label: Unknown\nConfidence: -%';
//       }
//     }

//     // No predictions or empty list, consider it as unknown
//     return 'Label: Unknown\nConfidence: -%';
//   }

//   loadModel() async {
//     await Tflite.loadModel(
//       model: "assets/model/model_unquant.tflite",
//       labels: "assets/model/labels.txt",
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Live Face Recognition App"),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Container(
//               height: MediaQuery.of(context).size.height * 0.7,
//               width: MediaQuery.of(context).size.width,
//               child: !cameraController!.value.isInitialized
//                   ? Container()
//                   : AspectRatio(
//                       aspectRatio: cameraController!.value.aspectRatio,
//                       child: CameraPreview(cameraController!),
//                     ),
//             ),
//           ),
//           Text(
//             output,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//           )
//         ],
//       ),
//     );
//   }
// }

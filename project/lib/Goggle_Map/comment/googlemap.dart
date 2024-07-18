// import 'dart:async';

// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GooGleMap extends StatefulWidget {
//   const GooGleMap({Key? key}) : super(key: key);

//   @override
//   _GooGleMapState createState() => _GooGleMapState();
// }

// class _GooGleMapState extends State<GooGleMap> {
//   var c1;
//   // GeoLocator Package
//   // to know if location is turned on or off
//   Future<void> getPosition() async {
//     bool services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//     print(services);
//     if (services == false) {
//       AwesomeDialog(
//         context: context,
//         title: "services",
//         body: const Text("Services Not Enabled"),
//       ).show();
//     }

//     // if cannot reach to location Make a request
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per = await Geolocator.requestPermission();
//       if (per == LocationPermission.always) {
//         getLatAndLong();
//       }
//     }
//     print("========================");
//     print(per);
//     print("========================");
//   }

//   Future<Position> getLatAndLong() async {
//     // LatAndLong  for currentuser
//     return await Geolocator.getCurrentPosition().then((value) => value);
//   }

//   @override
//   void initState() {
//     getPosition();
//     super.initState();
//   }

//   // for Google MAP
//   final Completer<GoogleMapController> _controller =
//       Completer<GoogleMapController>();
//   static const CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(31.1671058, 29.8704577),
//     zoom: 14.4746,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Map"),
//       ),
//       body: Column(
//         children: [
//           Container(
//             // ignore: sort_child_properties_last
//             child: GoogleMap(
//               mapType: MapType.normal,
//               initialCameraPosition: _kGooglePlex,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ),
//             height: 650,
//             width: 400,
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               c1 = await getLatAndLong();
//               print("Lat  ${c1.latitude}");
//               print("Long ${c1.latitude}");
//             },
//             child: const Text("Show Lat and Long"),
//           ),
//         ],
//       ),
//     );
//   }
// }

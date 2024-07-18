// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GetUserLocation extends StatefulWidget {
//   const GetUserLocation({super.key});

//   @override
//   State<GetUserLocation> createState() => _GetUserLocationState();
// }

// class _GetUserLocationState extends State<GetUserLocation> {
//   final Completer<GoogleMapController> _controller = Completer();
//   static const CameraPosition _initialPosition = CameraPosition(
//       target: LatLng(31.215676854540305, 29.94230974196024), zoom: 14);
//   final List<Marker> myMarker = [];
//   final List<Marker> markerList = [
//     Marker(
//         // visible:true,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         markerId: const MarkerId('First'),
//         position: const LatLng(31.21614912308866, 29.938000411984298),
//         infoWindow: const InfoWindow(title: "أبو قير"))
//   ];
//   void initState() {
//     super.initState();
//     packData();
//     myMarker.addAll(markerList);
//   }

//   //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!userlocation function
//   // Request permission explicitly and check if it's granted
//   Future<bool> requestLocationPermission() async {
//     final status = await Geolocator.requestPermission();
//     return status == LocationPermission.always ||
//         status == LocationPermission.whileInUse;
//   }

//   // Get user location if permission is granted
//   Future<Position?> getUserLocation() async {
//     final hasPermission = await requestLocationPermission();

//     if (hasPermission) {
//       try {
//         return await Geolocator.getCurrentPosition();
//       } catch (e) {
//         print('Error getting location: $e');
//         return null;
//       }
//     } else {
//       print('Location permission denied.');
//       return null;
//     }
//   }

//   //!Marker with my position
//   //! Marker with my position
//   packData() {
//     getUserLocation().then((value) async {
//       if (value != null) {
//         print("MyLocation");
//         print('${value.latitude} ${value.longitude}');
//         myMarker.add(Marker(
//           markerId: MarkerId("Second"),
//           position: LatLng(value.latitude, value.longitude),
//           infoWindow: InfoWindow(title: "My Location"),
//         ));
//         //! Camera position
//         CameraPosition cameraPosition = CameraPosition(
//           target: LatLng(value.latitude, value.longitude),
//           zoom: 14,
//         );
//         final GoogleMapController controller = await _controller.future;
//         controller
//             .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//         setState(() {});
//       } else {
//         // Handle the case where user location is not available or permission is denied.
//         print('User location not available or permission denied.');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         //! we should recall mark and Polyline inside google map
//         child: GoogleMap(
//             initialCameraPosition: _initialPosition,
//             mapType: MapType.normal,
//             markers: Set<Marker>.of(myMarker),
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //this method for user location
//           packData();
//         },
//         child: Icon(Icons.radio_button_off),
//       ),
//     );
//   }
// }

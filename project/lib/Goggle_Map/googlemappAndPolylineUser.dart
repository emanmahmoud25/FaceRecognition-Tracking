import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Goggle_Map/widget_map/MarkerList.dart';
import 'package:project/Goggle_Map/widget_map/customInfo.dart';
import 'package:project/Goggle_Map/widget_map/customInfowDesign.dart';
import 'package:project/Goggle_Map/widget_map/latlangList.dart';
import 'package:project/Goggle_Map/widget_map/position.dart';

class GoogleMapp extends StatefulWidget {
  const GoogleMapp({Key? key}) : super(key: key);

  @override
  State<GoogleMapp> createState() => _GoogleMappState();
}

class _GoogleMappState extends State<GoogleMapp> {
  late final Completer<GoogleMapController> _controller = Completer();
  // final DatabaseReference _databaseRef =
  //     FirebaseDatabase.instance.ref().child('users');
  // Map<MarkerId, Marker> _databaseMarkers = {};
  Map<MarkerId, Marker> _mapMarkers = {};
  // CustomInfoWindowController customInfoWindowController =
  //     CustomInfoWindowController();
//! to make marker as photo (user)
  Future<void> setMarkerCustomImage(Position userLocation) async {
    myMarker.add(Marker(
      draggable: true,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(20, 20)),
          'assets/icons/trackingg.png'),
      markerId: const MarkerId('Fifth'),
      position: LatLng(userLocation.latitude, userLocation.longitude),
      // infoWindow: const InfoWindow(title: "User Location"),
      onTap: () {
        customInfoWindowController.addInfoWindow!(
            CustomInfoMarker(
              imagePath: "assets/Markers_Photos/photo1.jpg",
              locationName: 'الورديان',
              description: 'قسم مينا البصل\n محافظة الإسكندرية ',
            ),
            LatLng(userLocation.latitude, userLocation.longitude));
      },
    ));

    setState(() {});
  }

  Future<void> setMarkerCustomImage2() async {
    myMarker.add(Marker(
      draggable: true,
      icon: await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(size: Size(15, 15)),
          'assets/Markers_Photos/camera11.png'),
      markerId: const MarkerId('theif'),
      position: LatLng(31.207579931803515, 29.94289829795224),
      // infoWindow: const InfoWindow(title: "User Location"),
      onTap: () {
        customInfoWindowController.addInfoWindow!(
            const CustomInfoMarker(
              imagePath: "assets/Markers_Photos/كليهههه.jpg",
              locationName:
                  'كلية الدراسات الاقتصادية والعلوم السياسية جامعة الإسكندرية',
              description:
                  ' البرت الأول، عزبة سعد، قسم سيدى جابر، محافظة الإسكندرية ',
            ),
            LatLng(31.207579931803515, 29.94289829795224));
      },
    ));

    setState(() {});
  }

  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(31.203992680515846, 29.945689861991458), zoom: 14);
  //! to make Polyline for specific place  with its cardetial
  final Set<Polygon> _myPolygone = HashSet<Polygon>();

//! make Markers
  final List<Marker> myMarker = [];

  //! initState to implemnte Polyline and marks list
  @override
  void initState() {
    super.initState();
    // _listenForLocationUpdates();

    // customInfoWindowController = CustomInfoWindowController();
    _myPolygone.add(Polygon(
        polygonId: PolygonId("First"),
        points: points,
        fillColor: Colors.cyan.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.red));
    myMarker.addAll(markerList);
    setMarkerCustomImage2();

    packData();
    //to run function we should put it in initial state
  }

//!!!!!!!!!!!!!!!!!!!!!!!1 realtime database
  // void _listenForLocationUpdates() {
  //   _databaseRef.onValue.listen((event) {
  //     final Map<dynamic, dynamic>? data =
  //         event.snapshot.value as Map<dynamic, dynamic>?;

  //     if (data != null) {
  //       setState(() {
  //         _databaseMarkers.clear(); // Clear existing markers

  //         data.forEach((key, value) {
  //           final name = value['final_name'];
  //           final latitude = double.tryParse(value['latitude'].toString());
  //           final longitude = double.tryParse(value['longitude'].toString());

  //           if (name != null && latitude != null && longitude != null) {
  //             final position = LatLng(latitude, longitude);
  //             final markerId = MarkerId(key);
  //             final marker = Marker(
  //               markerId: markerId,
  //               position: position,
  //               infoWindow: InfoWindow(
  //                 title: name.toString(),
  //                 snippet: 'Location: ${value['location_element']}',
  //               ),
  //             );

  //             _databaseMarkers[markerId] = marker;
  //           }
  //         });
  //       });
  //     }
  //   });
  // }

//! Marker with my position
  Future<void> packData() async {
    Position? userLocation =
        await getLatAndLong(); // Use await here to wait for the result
    if (userLocation != null) {
      print("MyLocation");
      print('${userLocation.latitude} ${userLocation.longitude}');
      await setMarkerCustomImage(userLocation);

      //! Camera position
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    } else {
      // Handle the case where user location is not available or permission is denied.
      print('User location not available or permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    _mapMarkers.clear();
    // _mapMarkers.addEntries(_databaseMarkers.entries);
    _mapMarkers.addEntries(
        myMarker.map((marker) => MapEntry(marker.markerId, marker)));

    return Scaffold(
      body: SafeArea(
          //! we should recall mark and Polyline inside google map
          child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            polygons: _myPolygone,
            markers: _mapMarkers.values.toSet(),
            //!for custom infow
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              customInfoWindowController.googleMapController = controller;
              //!!
            },
          ),
          ////!for Custom Window

          Custominfoo(customInfoWindowController: customInfoWindowController),
        ],
      )),

      //!to make animate camera  to when i click to it focous on specific area
      // floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.location_searching),
      //   onPressed: () async {
      //     // Replace 'userId', 'name', 'newLatitude', 'newLongitude', and 'location' with actual values
      //     updateLocation(
      //         '-O-5wFN-zGRgnLTYFAvX',
      //         'bill-simon',
      //         31.161379833333328,
      //         29.864815,
      //         '11 El Aman Street, Qesm Mina El Basal, Alexandria, Egypt');

      //     // Wait for the controller to be initialized
      //     GoogleMapController controller = await _controller.future;

      //     // Get the new location coordinates from the updateLocation method
      //     double newLatitude = 31.161379833333328;
      //     double newLongitude = 29.864815;
      //     // Animate the camera to the new location
      //     controller.animateCamera(CameraUpdate.newCameraPosition(
      //       CameraPosition(
      //         target: LatLng(newLatitude, newLongitude),
      //         zoom: 18,
      //       ),
      //     ));

      //     // Update the UI
      //     setState(() {});
      //   },
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: LatLng(31.21596207951673, 29.942465071496887),
                    zoom: 13.5)));
            setState(() {});
          }),
    );
  }
}

import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/Goggle_Map/widget_map/customInfo.dart';
import 'package:project/Goggle_Map/widget_map/customInfowDesign.dart';
import 'package:project/Goggle_Map/widget_map/position.dart';
import 'package:project/map_realtime/updatemarkers.dart';

class LocationMapPage extends StatefulWidget {
  @override
  _LocationMapPageState createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  Map<MarkerId, Marker> _databaseMarkers = {};
  static const CameraPosition _initialPosition = CameraPosition(
      target: LatLng(31.203992680515846, 29.945689861991458), zoom: 14);
  late final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController _mapController;
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('users');
  Map<MarkerId, Marker> _markers = {};

  final CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  final List<LatLng> _polylineCoordinates = [];
  PolylineId polylineId = PolylineId("line");

  late StreamSubscription<DatabaseEvent> _locationSubscription;

  @override
  void initState() {
    super.initState();
    _listenForLocationUpdates();
    packData();
  }

  @override
  void dispose() {
    // Dispose of the custom info window controller
    customInfoWindowController.dispose();

    // Cancel the location subscription
    _locationSubscription.cancel();

    super.dispose();
  }

  void _listenForLocationUpdates() {
    _locationSubscription = _databaseRef.onValue.listen((event) {
      final Map<dynamic, dynamic>? data =
          event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        if (mounted) {
          setState(() {
            _databaseMarkers.clear(); // Clear existing markers

            data.forEach((key, value) {
              final name = value['final_name'];
              final latitude = double.tryParse(value['latitude'].toString());
              final longitude = double.tryParse(value['longitude'].toString());

              if (name != null && latitude != null && longitude != null) {
                final position = LatLng(latitude, longitude);
                final markerId = MarkerId(key);
                final marker = Marker(
                  markerId: markerId,
                  position: position,
                  infoWindow: InfoWindow(
                    title: name.toString(),
                    snippet: 'Location: ${value['location_element']}',
                  ),
                );

                _databaseMarkers[markerId] = marker;

                // Add coordinates to polyline
                _polylineCoordinates.add(position);
              }
            });
          });
        }
      }
    });
  }

  Future<void> packData() async {
    Position? userLocation =
        await getLatAndLong(); // Use await here to wait for the result
    if (userLocation != null) {
      print("MyLocation");
      print('${userLocation.latitude} ${userLocation.longitude}');
      await setMarkerCustomImage(userLocation);

      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(userLocation.latitude, userLocation.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      // Add user's location to polyline
      if (mounted) {
        setState(() {
          _polylineCoordinates
              .add(LatLng(userLocation.latitude, userLocation.longitude));
        });
      }
    } else {
      // Handle the case where user location is not available or permission is denied.
      print('User location not available or permission denied.');
    }
  }

  @override
  Widget build(BuildContext context) {
    _markers.clear();
    _markers.addEntries(_databaseMarkers.entries);
    _markers.addEntries(
        myMarker.map((marker) => MapEntry(marker.markerId, marker)));

    Set<Polyline> _polylines = {
      Polyline(
        polylineId: polylineId,
        visible: true,
        points: _polylineCoordinates,
        color: const Color.fromARGB(255, 33, 243, 65),
        width: 5,
      ),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Location Tracking'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialPosition,
            mapType: MapType.normal,
            markers: Set<Marker>.of(_markers.values),
            polylines: _polylines,
            onTap: (position) {
              customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              customInfoWindowController.googleMapController = controller;
            },
          ),
          Custominfoo(customInfoWindowController: customInfoWindowController),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_searching),
        onPressed: () async {
          // Replace 'userId', 'name', 'newLatitude', 'newLongitude', and 'location' with actual values
          updateLocation(
              '-O-BGCTl_a16N-miSVQA',
              'mohammed-ali',
              31.161379833333328,
              29.864815,
              '11 El Aman Street, Qesm Mina El Basal, Alexandria, Egypt');

          // Wait for the controller to be initialized
          GoogleMapController controller = await _controller.future;

          // Get the new location coordinates from the updateLocation method
          double newLatitude = 31.161379833333328;
          double newLongitude = 29.864815;
          // Animate the camera to the new location
          controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(newLatitude, newLongitude),
              zoom: 18,
            ),
          ));

          // Add new location to polyline
          if (mounted) {
            setState(() {
              _polylineCoordinates.add(LatLng(newLatitude, newLongitude));
            });
          }
        },
      ),
    );
  }

  final List<Marker> myMarker = [];

  Future<void> setMarkerCustomImage(Position userLocation) async {
    myMarker.add(Marker(
      draggable: true,
      icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: const Size(20, 20)),
          'assets/icons/trackingg.png'),
      markerId: const MarkerId('Fifth'),
      position: LatLng(userLocation.latitude, userLocation.longitude),
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

    if (mounted) {
      setState(() {});
    }
  }
}

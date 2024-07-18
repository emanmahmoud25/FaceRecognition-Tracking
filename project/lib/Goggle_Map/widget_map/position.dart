import 'package:geolocator/geolocator.dart';

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!userlocation function
// Request permission explicitly and check if it's granted

// !!Get user location if permission is granted enable location if i turn off

Future<void> getPosition() async {
  // bool services;
  LocationPermission per;
  per = await Geolocator.checkPermission();
  if (per == LocationPermission.denied) {
    per = await Geolocator.requestPermission();
    if (per == LocationPermission.always ||
        per == LocationPermission.whileInUse) {
      await getLatAndLong(); // Use await here to wait for the result
    } else {
      // Handle the case where permission is not granted.
      print("Location permission not granted");
    }
  }
}

Future<Position?> getLatAndLong() async {
  try {
    // LatAndLong for current user
    return await Geolocator.getCurrentPosition();
  } catch (e) {
    // Handle the error, e.g., show an error message to the user.
    print("Error getting location: $e");
    return null;
  }
}

// Function to update location in Firebase
import 'package:firebase_database/firebase_database.dart';

void updateLocation(String userId, String name, double latitude,
    double longitude, String location) {
  final DatabaseReference _databaseRef =
      FirebaseDatabase.instance.ref().child('users').child(userId);
  _databaseRef.set({
    'final_name': name,
    'latitude': latitude,
    'longitude': longitude,
    'location_element': location,
  }).catchError((error) {
    // Handle error
    print('Error: $error');
  });
}

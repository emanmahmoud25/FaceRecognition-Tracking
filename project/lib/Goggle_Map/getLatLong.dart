import 'package:geolocator/geolocator.dart';

// class TransformLatAndLongToAddress extends StatefulWidget {
//   const TransformLatAndLongToAddress({super.key});

//   @override
//   State<TransformLatAndLongToAddress> createState() =>
//       _TransformLatAndLongToAddressState();
// }

// class _TransformLatAndLongToAddressState
//     extends State<TransformLatAndLongToAddress> {
//get location for user
// Future<void> getPosition() async {
//   bool services;
//   LocationPermission per;
//   services = await Geolocator.isLocationServiceEnabled();
//   print(services);
//   if (services == false) {
//     AwesomeDialog(
//       context: context,
//       title: "services",
//       body: const Text("Services Not Enabled"),
//     ).show();
//   }
// }

//! LatAndLong  for currentuser

Future<Position> getLatAndLong() async {
  LocationPermission permission = await Geolocator.requestPermission();

  if (permission == LocationPermission.denied) {
    // Handle the case where the user denied location permissions
    print('Location permission denied');
    return Future.error('Location permission denied');
  }

  return await Geolocator.getCurrentPosition();
}

//   String placeMe = '';
//   String placeuser = '';
//   String distanceText = '';
//   @override
//   Widget build(BuildContext context) {
//     //to check if text arabic or english
//     bool isRTL = Intl.getCurrentLocale().toLowerCase().contains('ar');

//     return Container(
//         decoration: const BoxDecoration(
//             gradient: LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [
//             Color.fromARGB(255, 222, 244, 254),
//             Color.fromARGB(255, 227, 207, 255)
//           ],
//         )),
//         child: Scaffold(
//           // to gradaint show
//           backgroundColor: Colors.transparent,
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //! user location text
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: Text(
//                   "User location :${placeMe}",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Intel",
//                   ),
//                   textAlign: isRTL ? TextAlign.right : TextAlign.left,
//                 ),
//               ),
//               //! person location text
//               Padding(
//                 padding: const EdgeInsets.all(30),
//                 child: Text(
//                   "Camera1 location :${placeuser}",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Intel",
//                   ),
//                   textAlign: isRTL ? TextAlign.right : TextAlign.left,
//                 ),
//               ),
// //!user location
//               GestureDetector(
//                 onTap: () async {
//                   Position c1 = await getLatAndLong();
//                   // List<Placemark> placemark = await placemarkFromCoordinates(
//                   //     25.167396429086434, 29.873985696442265);
//                   //to get my location

//                   List<Placemark> placemark =
//                       await placemarkFromCoordinates(c1.latitude, c1.longitude);
//                   setState(() {
//                     placeMe = '${placemark.reversed.last.country} \n'
//                         'postalCode: ${placemark.reversed.last.street}\n'
//                         'Latitude: ${c1.latitude}\nLongitude: ${c1.longitude}';
//                   });

//                   //! person location by latlng

//                   List<Placemark> placemark2 = await placemarkFromCoordinates(
//                       31.219998023546978, 29.946125356949633);
//                   setState(() {
//                     placeuser = '${placemark2.reversed.last.country} \n'
//                         'postalCode: ${placemark2.reversed.last.street}\n'
//                         'Latitude: ${31.207579931803515}\nLongitude: ${29.94289829795224}';
//                   });
//                 },
//                 //!button for location
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [
//                               Color.fromARGB(255, 180, 231, 255),
//                               Color.fromARGB(255, 208, 174, 255)
//                             ]),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                               blurRadius: 1,
//                               spreadRadius: 0.5,
//                               offset: Offset(1, 1))
//                         ]),
//                     child: const Center(child: Text("Location")),
//                   ),
//                 ),
//               ),
//               //!get distance between them
//               GestureDetector(
//                 onTap: () async {
//                   Position c1 = await getLatAndLong();
//                   var distanceBetween = Geolocator.distanceBetween(c1.latitude,
//                       c1.longitude, 31.219998023546978, 29.946125356949633);
//                   setState(() {
//                     distanceText =
//                         "Distance Between: ${distanceBetween / 1000} km";
//                   });
//                 },
//                 //! text and button for distance
//                 child: Padding(
//                   padding: const EdgeInsets.all(18),
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         gradient: const LinearGradient(
//                             begin: Alignment.centerLeft,
//                             end: Alignment.centerRight,
//                             colors: [
//                               Color.fromARGB(255, 180, 231, 255),
//                               Color.fromARGB(255, 208, 174, 255)
//                             ]),
//                         borderRadius: BorderRadius.circular(10),
//                         boxShadow: const [
//                           BoxShadow(
//                               blurRadius: 1,
//                               spreadRadius: 0.5,
//                               offset: Offset(1, 1))
//                         ]),
//                     child: const Center(child: Text("Show distance")),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   height:
//                       20), // Add some spacing between buttons and distance text
//               Text(
//                 distanceText,
//                 style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Intel",
//                 ),
//                 textAlign: isRTL ? TextAlign.right : TextAlign.left,
//               )
//             ],
//           ),
//         ));
//   }
// }

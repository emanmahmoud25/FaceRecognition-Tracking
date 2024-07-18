// import "dart:convert";

// import "package:flutter/material.dart";
// import "package:geocoding/geocoding.dart";
// import 'package:http/http.dart' as http;
// import "package:project/constants/Colors.dart";
// import "package:uuid/uuid.dart";

// class Search_Map extends StatefulWidget {
//   const Search_Map({super.key});

//   @override
//   State<Search_Map> createState() => _Search_MapState();
// }

// class _Search_MapState extends State<Search_Map> {
//   String tokenForSession = '123456';
//   var uuid = Uuid();
//   List<dynamic> listPlaces = [];
//   final TextEditingController _controller = TextEditingController();
//   void makesuggestion(String input) async {
//     String googleplacesApiKey = "AIzaSyB_pxt-BjXeUE7JNvBxUAkf6qkC25T1YeM";
//     String groundURL =
//         'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//     // ignore: unused_local_variable
//     String request =
//         '$groundURL?input=$input&key=$googleplacesApiKey&sessiontoken=$tokenForSession';
//     var responseResult = await http.get(Uri.parse(request));
//     var Resultdate = responseResult.body.toString();
//     print("Result Date");
//     print(Resultdate);

//     if (responseResult.statusCode == 200) {
//       setState(() {
//         listPlaces = jsonDecode(responseResult.body.toString())['predictions'];
//       });
//     } else {
//       print("#############Showing Data Failed,Try Again");
//     }
//   }

//   void onModify() {
//     if (tokenForSession == null) {
//       setState(() {
//         tokenForSession = uuid.v4();
//       });
//     }
//     makesuggestion(_controller.text);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       onModify();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: AppColors.WelcomePageBackGround,
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text(
//             "Places Api Google Map Search",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: "Intel",
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//         ),
//         body: Padding(
//           padding: EdgeInsets.symmetric(vertical: 12),
//           child: Column(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: TextFormField(
//                     controller: _controller,
//                     decoration: InputDecoration(hintText: "Search Here"),
//                   )),
//               Expanded(
//                   child: ListView.builder(
//                       itemCount: listPlaces.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           onTap: () async {
//                             List<Location> locations =
//                                 await locationFromAddress(
//                                     listPlaces[index]['description']);
//                             print(locations.last.latitude);
//                             print(locations.last.longitude);
//                           },
//                           title: Text(listPlaces[index]['description']),
//                         );
//                       }))
//             ],
//           ),
//         ));
//   }
// }

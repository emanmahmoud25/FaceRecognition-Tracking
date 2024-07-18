// import 'package:flutter/material.dart';
// import 'package:project/constants/Colors.dart';

// class ShowData extends StatefulWidget {
//   const ShowData({super.key});

//   @override
//   State<ShowData> createState() => _ShowDataState();
// }

// class _ShowDataState extends State<ShowData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Center(
//               child: Text(
//             "All Data      ",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontFamily: "Poppins",
//             ),
//           )),
//           elevation: 0,
//           // actions: [
//           //   IconButton(
//           //     onPressed: () {
//           //       Navigator.pushNamedAndRemoveUntil(
//           //           context, "home", (route) => false);
//           //     },
//           //     icon: const Icon(Icons.exit_to_app),
//           //   )
//           // ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20),
//           child: Center(
//             child: ListView(
//               // mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                     ////!! to make scrool in table
//                     child: Container(
//                   height: 650,
//                   margin: const EdgeInsets.symmetric(horizontal: 21),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                   decoration: BoxDecoration(
//                     color: AppColors.WelcomePageBackGround.withOpacity(0.94),
//                     borderRadius: const BorderRadius.all(Radius.circular(40)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.3),
//                         spreadRadius: 2.5,
//                         blurRadius: 10,
//                         offset: Offset(0, 3), // Offset in the x and y direction
//                       ),
//                     ],
//                   ),
//                   // color: AppColors.WelcomePageBackGround,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: DataTable(
//                         headingRowColor:
//                             MaterialStateProperty.all((Colors.white)),
//                         columns: const [
//                           DataColumn(
//                               label: Text(
//                             "Id",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: "Poppins",
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             "Location",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: "Poppins",
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             "Persons",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: "Poppins",
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           )),
//                           DataColumn(
//                               label: Text(
//                             "Date",
//                             style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: "Poppins",
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.red),
//                           )),
//                         ],
//                         rows: const [
//                           DataRow(cells: [
//                             DataCell(Text('1')),
//                             DataCell(Text('15RamsisStreet')),
//                             DataCell(Text('person1')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             )),
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('2')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person2')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('3')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person3')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('4')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person4')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('5')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person5')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('6')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person5')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('7')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person6')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('8')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person7')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('9')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person9')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                           DataRow(cells: [
//                             DataCell(Text('10')),
//                             DataCell(Text('65smohaStreet')),
//                             DataCell(Text('person10')),
//                             DataCell(Text(
//                               '2023-03-25 \n    16:25',
//                             ))
//                           ]),
//                         ]),
//                   ),
//                 ))
//               ],
//             ),
//           ),
//         ));
//   }
// }

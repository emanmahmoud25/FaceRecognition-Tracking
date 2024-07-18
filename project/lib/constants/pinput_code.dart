// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:project/screens/phone_verifycode.dart/phonescreen.dart';

// class MyVerify extends StatefulWidget {
//   const MyVerify({Key? key}) : super(key: key);

//   @override
//   State<MyVerify> createState() => _MyVerifyState();
// }

// class _MyVerifyState extends State<MyVerify> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   String code = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Phone Verification"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Your UI elements here

//             PinCodeTextField(
//               appContext: context,
//               length: 6,
//               onChanged: (value) {
//                 setState(() {
//                   code = value;
//                 });
//               },
//               // Other customization options can be applied here
//             ),

//             SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: MyPhone.verify,
//                     smsCode: code,
//                   );
//                   await auth.signInWithCredential(credential);
//                   Navigator.pushNamedAndRemoveUntil(
//                     context,
//                     "phone",
//                     (route) => false,
//                   );
//                 } catch (e) {
//                   print("xxxxxxxxx  WrongOtp");
//                 }
//               },
//               child: Text("Verify Phone Number"),
//             ),

//             Row(
//               children: [
//                 TextButton(
//                     onPressed: () {
//                       Navigator.pushNamedAndRemoveUntil(
//                         context,
//                         'phone',
//                         (route) => false,
//                       );
//                     },
//                     child: Text(
//                       "Edit Phone Number ?",
//                       style: TextStyle(color: Colors.black),
//                     ))
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:rive/rive.dart';

// import '../../Widget/Animate_Button_WelcomePage.dart';
// import '../../constants/Colors.dart';
// import '../Signin_Signup.dart/CustomSignInDialog.dart';

// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});
//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   late RiveAnimationController _btnAnimationController;
//   @override
//   void initState() {
//     _btnAnimationController = OneShotAnimation("active", autoplay: false);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.WelcomePageBackGround,
//       body: Stack(
//         children: [
//           Positioned(
//               // height: 100,
//               width: MediaQuery.of(context).size.width * 1.7,
//               bottom: 200,
//               left: 100,
//               child: Image.asset("assets/Backgrounds/Spline.png")),
//           Positioned.fill(
//               child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//           )),
//           const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
//           Positioned.fill(
//               child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 30, sigmaY: 45),
//             child: const SizedBox(),
//           )),
//           SafeArea(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
//             child:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               // Spacer(),
//               SizedBox(
//                   width: 260,
//                   // height: 220,
//                   child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           'Face Recognition',
//                           style: TextStyle(fontSize: 40, fontFamily: "Poppins"),
//                         ),
//                         const SizedBox(
//                             height: 10), // Adjust the height as needed

//                         const Center(
//                           child: Text(
//                             '&    ',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                             height: 10), // Adjust the height as needed

//                         const Text(
//                           'Detection',
//                           style: TextStyle(fontSize: 40, fontFamily: "Poppins"),
//                         ),
//                         const SizedBox(height: 16),
//                         // Text(
//                         //   'Here I will write anything about the project,\n'
//                         //   'Here I will write anything about the project',
//                         // ),
//                         Lottie.asset(
//                             'assets/Lottie/Animation - 1701071558347.json',
//                             height: 300),
//                       ])),
//               // const Spacer(
//               //   flex: 1,
//               // ),
//               const SizedBox(
//                 height: 35,
//               ),
//               //Start Button
//               AnimatedButton(
//                 btnAnimationController: _btnAnimationController,
//                 press: () {
//                   _btnAnimationController.isActive = true;
//                   //to show animation button move after we close dialoude signin
//                   Future.delayed(Duration(milliseconds: 800), () {
//                     CustomSignInDialog(context);
//                   });
//                 },
//                 btnAnimationColtroller: _btnAnimationController,
//               ),
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 24),
//                 child: Text("here some details and what we used"),
//               ),
//             ]),
//           ) // Adjust the height as needed
//               )
//         ],
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/Controller/google_Signincontroller.dart';
import 'package:project/screens/Signin_Signup.dart/SignUp.dart';
import 'package:project/service/Auth.dart';
import 'package:project/service/Otp_Hindi.dart/phonescreen.dart';

import '../../constants/Colors.dart';
import 'SignIn_Form&Auth.dart';

// ignore: non_constant_identifier_names
Future<Object?> CustomSignInDialog(BuildContext context) {
  final GoogleSignInController googleSignInController =
      GoogleSignInController(FirebaseAuthMethods(FirebaseAuth.instance));
  // final PhoneScreenController _controller = PhoneScreenController();
  // String email = _LoginController.emailController.text;
  return showGeneralDialog(
    // to close it while tap outside
    //add the close btn at the bottom
    barrierDismissible: true,
    barrierLabel: "Sign In",
    context: context,
    //add slide animation while dialoug
    //to dialloug slide come from top
    transitionDuration: Duration(milliseconds: 400),
    transitionBuilder: (_, animation, __, child) {
      Tween<Offset> tween;
      tween = Tween(
          begin: const Offset(
            0,
            -1,
          ),
          end: Offset.zero);
      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        ),
        child: child,
      );
    },
    //////////////////////////////////////////
    pageBuilder: ((context, _, __) => Center(
          child: Container(
            height: 620,
            margin: const EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration: BoxDecoration(
                color: AppColors.pagesBackground.withOpacity(0.94),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              // backgroundColor: Colors.transparent,
              body: Stack(
                clipBehavior: Clip.none,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Sign In",
                        // textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: "Poppins", fontSize: 28),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Welcome Back",
                        ),
                      ),
                      const SigningForm(),
                      const Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "OR",
                              style: TextStyle(color: AppColors.lightblack),
                            ),
                          ),
                          Expanded(child: Divider()), //Divider is Line
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Sign Up With Email,Phone Or Google ",
                          style: TextStyle(color: AppColors.lightblack),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/email_box.svg",
                                height: 50,
                                width: 50,
                              )),
                          IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyPhone()),
                              );
                            },
                            icon: Transform.rotate(
                              angle: 45 *
                                  3.141592653589793 /
                                  180, // Set the angle in terms of radians
                              child: SvgPicture.asset(
                                "assets/icons/1181187_app_call_viber_icon.svg",
                                height: 44,
                                width: 44,
                              ),
                            ),
                          ),
                          IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                // signInWithGoogle(context);
                                await googleSignInController
                                    .signInWithGoogle(context);
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/google_box.svg",
                                height: 50,
                                width: 50,
                              ))
                        ],
                      )
                    ],
                  ),
                  //Button to close daialog
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -60,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
  );
}

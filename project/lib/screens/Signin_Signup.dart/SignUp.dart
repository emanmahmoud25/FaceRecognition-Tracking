import 'package:flutter/material.dart';
import 'package:project/screens/Signin_Signup.dart/signUp_Form&Auth.dart';

import '../../constants/Colors.dart';
import 'CustomSignInDialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Stack(
        // clipBehavior: Clip.none,

        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 120),
                  child: Text(
                    "Sign Up",
                    // textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Poppins", fontSize: 29),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Welcome Back",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: SignUpForm(),
                ),
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
                    Expanded(
                        child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Divider(),
                    )), //Divider is Line
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: InkWell(
                    onTap: () {
                      CustomSignInDialog(context);
                    },
                    child: const Center(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(text: "Have An Account ?"),
                        TextSpan(
                            text: " Login",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold)),
                      ])),
                    ),
                  ),
                )
              ],
            ),
          ),
          //Button to close daialog
          // const Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: -48,
          //   child: CircleAvatar(
          //     radius: 16,
          //     backgroundColor: Colors.white,
          //     child: Icon(
          //       Icons.close,
          //       color: Colors.black,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}

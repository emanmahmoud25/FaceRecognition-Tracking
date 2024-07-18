import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:project/constants/Colors.dart';
import 'package:project/constants/showsnackBar.dart';
import 'package:project/service/Otp_Hindi.dart/phonescreen.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});
  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/Backgrounds/Wavy_Tech-01_Single-07.jpg',
                //   width: 150,
                //   height: 150,
                // ),
                Container(
                  width: 170,
                  height: 170,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.buttonColor,
                  ),
                  //!! to make photo as circle
                  child: ClipOval(
                    child: Image.asset(
                      'assets/Backgrounds/Wavy_Tech-01_Single-07.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
                const Text(
                  " Verification",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Enter your OTP \n code number",
                  style: TextStyle(
                      fontSize: 13, color: Color.fromARGB(135, 79, 79, 79)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  showCursor: true,
                  onChanged: (value) {
                    code = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: MyPhone.verify, smsCode: code);

                      // Sign the user in (or link) with the credential
                      await auth.signInWithCredential(credential);
                      Navigator.pushNamedAndRemoveUntil(
                          context, "home", (route) => false);
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ShowSnackBar(context, 'Wrong Otp');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF77D8E),
                      minimumSize: const Size(340, 54),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ))),
                  icon: const Icon(CupertinoIcons.arrow_right,
                      color: AppColors.RawColoronButton),
                  label: const Text("Verify Phone Number"),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'phone',
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Edit Phone Number ?",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ))));
  }
}

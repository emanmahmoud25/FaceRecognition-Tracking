import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/constants/showsnackBar.dart';
import 'package:project/screens/sideMenu/connectHomeScreen&menuBar.dart';

import '../screens/Signin_Signup.dart/CustomSignInDialog.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // ! ///////////////////////// Email SIGN UP
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // ignore: use_build_context_synchronously
      await sendEmailVerification(context);
      // Show a message to the user and instruct them to verify their email
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Success',
        desc:
            'User created successfully. Please check your email for verification.',
        btnOkOnPress: () {
          CustomSignInDialog(context);
        },
      ).show();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'The password provided is too weak.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Error',
          desc: 'The account already exists for that email.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
      }
    }
  }

  //!!!!! send email
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      await _auth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      // Handle exceptions related to sending email verification
      ShowSnackBar(context, e.message!);
      print('Error sending email verification: ${e.message}');
    }
  }

  // Call this method when the user presses the email verification link
  Future<void> handleEmailVerification(BuildContext context) async {
    await _auth.currentUser!.reload();
    if (_auth.currentUser!.emailVerified) {
      // Email is verified, navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_MenuSide()),
      );
    } else {
      // Show a message to the user indicating email verification is pending
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Info',
        desc: 'Email verification is pending. Please check your email.',
        btnOkOnPress: () {},
      ).show();
    }
  }

  //!!!!!!!!!!!!!!!!!!!!!!!!!!! EMAIL LOGIN
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (_auth.currentUser != null && !_auth.currentUser!.emailVerified) {
        // If email is not verified, show a message to the user
        // ignore: use_build_context_synchronously
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Info',
          desc: 'Please verify your email before proceeding.',
          btnCancelOnPress: () {},
          btnOkOnPress: () {},
        ).show();
        return; // Do not proceed to navigation
      }

      // If email is verified, navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home_MenuSide()),
      );
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      //   // Show the error dialog only for 'user-not-found' or 'wrong-password'
      //   AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.error,
      //     animType: AnimType.rightSlide,
      //     title: 'Error',
      //     desc: 'No user found or incorrect password.',
      //     btnCancelOnPress: () {},
      //     btnOkOnPress: () {},
      //   ).show();
      // } else {
      //   // Handle other FirebaseAuthExceptions if needed
      //   // print('Error: ${e.message}');
      // }
      // ShowSnackBar(context, e.message!);
      // ignore: use_build_context_synchronously
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Error',
        desc: 'Error: ${e.message}',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
      ).show();
    }
  }

  // Existing code...
//!delete account from firebase and
  Future<void> deleteAccount(BuildContext context) async {
    try {
      // Delete account from Firebase
      await _auth.currentUser?.delete();
      // ShowSnackBar(context, "Account have deleted succefuly");

      // Sign out from Google (if signed in with Google)
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      CustomSignInDialog(context);
      // Navigate to sign-in screen or any other appropriate screen
    } catch (e) {
      // Handle errors during account deletion
      // Display an error message to the user
      ShowSnackBar(context, 'Error deleting account: $e');
    }
  }

  //!!!!!!! phone Auth
//   Future<void> phoneSignIn(
//     BuildContext context,
//     String phoneNumber,
//   ) async {
//     TextEditingController codeController = TextEditingController();
// // for Web Only !!!!!!!!!
//     if (kIsWeb) {
//       ConfirmationResult result =
//           await _auth.signInWithPhoneNumber(phoneNumber);

//       //Display Dialog Box To Accept OTP
//       showOTPDialog(
//           context: context,
//           codeController: codeController,
//           onPressed: () async {
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: result.verificationId,
//               smsCode: codeController.text.trim(),
//               //  text.trim()  is used to remove any leading or trailing whitespaces from the entered code. It's a good practice to trim the input to ensure that there are no accidental spaces
//             );
//             await _auth.signInWithCredential(credential);
//             Navigator.of(context).pop();
//           });
//     } else {
//       //For ANDROID ,IOS
//       await _auth.verifyPhoneNumber(
//           phoneNumber: phoneNumber,
//           verificationCompleted: (PhoneAuthCredential credential) async {
//             await _auth.signInWithCredential(credential);
//           },
//           verificationFailed: (e) {
//             ShowSnackBar(context, e.message!);
//           },
//           codeSent: (String verificationId, int? resendToken) async {
//             showOTPDialog(
//                 context: context,
//                 codeController: codeController,
//                 onPressed: () async {
//                   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//                     verificationId: verificationId,
//                     smsCode: codeController.text.trim(),
//                   );
//                   await _auth.signInWithCredential(credential);
//                   Navigator.of(context).pop(); //Remove the dialoge box
//                 });
//           },
//           codeAutoRetrievalTimeout: (String verificationId) {
//             //if time code out we can write thing here
//           });
//     }
//   }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // If user cancels sign-in, return
      if (googleUser == null) {
        return;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with the credential
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      // Handle sign-in failure
      print("Sign-in error: $e");
    } finally {
      // Delay navigation for 1 second
      Timer(Duration(milliseconds: 1), () {
        // Navigate to the home screen after delay
        Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
      });
    }
  }
}

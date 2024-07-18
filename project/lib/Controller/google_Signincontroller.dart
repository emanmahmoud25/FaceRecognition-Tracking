import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../service/Auth.dart';

class GoogleSignInController {
  final FirebaseAuthMethods _authMethods;

  GoogleSignInController(this._authMethods);

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      await _authMethods.signInWithGoogle(context);
    } catch (e) {
      // Handle Google Sign-In errors, e.g., show an error message to the user.
      print('Google Sign-In failed: $e');
    }
  }

  Future<void> signOutFromGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
}

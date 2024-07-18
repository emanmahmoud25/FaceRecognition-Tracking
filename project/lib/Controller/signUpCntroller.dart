// signup_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/Auth.dart';

//make controller to connect to firebase
class SignUpController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
  }

  Future<void> signUpUser(BuildContext context) async {
    try {
      await FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    } catch (e) {
      // Handle sign-up errors, e.g., show an error message to the user.
      print('Sign-up failed: $e');
    }
  }
}

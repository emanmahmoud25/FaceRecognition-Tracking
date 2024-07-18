// signup_controller.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/Auth.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> LoginUser(BuildContext context) async {
    try {
      await FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    } catch (e) {
      // Handle sign-up errors, e.g., show an error message to the user.
      print('Sign-in failed: $e');
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      print('Password reset email sent to ${emailController.text}');
    } catch (e) {
      // Handle password reset errors, e.g., show an error message to the user.
      print('Password reset failed: $e');
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    try {
      await FirebaseAuthMethods(FirebaseAuth.instance).deleteAccount(context);
    } catch (e) {
      // Handle account deletion errors
      print('Account deletion failed: $e');
    }
  }
}

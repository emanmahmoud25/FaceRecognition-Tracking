

// Future<void> signInWithGoogle(BuildContext context) async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
// // this if i cancel to sign in not give
//   if (googleUser == null) {
//     return;
//   }

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth =
//       await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   // Once signed in, return the UserCredential
//   await FirebaseAuth.instance.signInWithCredential(credential);
//   // ignore: use_build_context_synchronously
//   Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
// }

// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/Controller/google_Signincontroller.dart';
import 'package:project/Controller/login_controller.dart';
import 'package:project/Goggle_Map/googlemappAndPolylineUser.dart';
import 'package:project/Models/models_rive_assets.dart';
import 'package:project/Notify/StoreMessages.dart';
import 'package:project/help_sendEmail/sendEmail.dart';
import 'package:project/map_realtime/tracking.dart';
import 'package:project/screens/HomePage/homeScreenWithOutBottmBar.dart';
import 'package:project/service/Auth.dart';
import 'package:rive/rive.dart';

// ignore: must_be_immutable
class SideMenuTile extends StatelessWidget {
  // final List<String> storedMessages;
  //! Add this line to StoredMessage

  SideMenuTile({
    super.key,
    required this.menu,
    required this.press,
    required this.riveonInit,
    required this.isActive,
    // required this.storedMessages,
  });
  final RiveAsset menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveonInit;
  final bool isActive;

  GoogleSignInController googleSignInController =
      GoogleSignInController(FirebaseAuthMethods(FirebaseAuth.instance));
  LoginController loginController = LoginController();

  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(
            color: Colors.white24,
            height: 1,
          ),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              height: 56,
              width: isActive ? 288 : 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFF9CC5FF),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
            ListTile(
              //!!!! to recall function to navigate to differnt pages
              onTap: () {
                press(); // Call the press function
                navigateToDestination(context, menu.title);
              },
              leading: SizedBox(
                height: 34,
                width: 34,
                child: RiveAnimation.asset(
                    // "assets/RiveAssets/icons.riv",
                    menu.src,
                    artboard: menu.artboard,
                    onInit:
                        //  (artboard) {},
                        riveonInit),
              ),
              title: Text(
                // "Home",
                menu.title,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ///!!!!!!!!!!!!!!!!!!!!!!!!!!!to Navigate to different pages
  Future<void> navigateToDestination(BuildContext context, String title) async {
    switch (title) {
      case "Home":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case "Map":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => GoogleMapp()));
        break;
      case "GPS":
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LocationMapPage()));
        break;
      // case "Favorites":
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => Navigate()));
      //   break;
      case "Help":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SendMyEmail()));
        break;
      case "Delete":
        loginController.deleteAccount(context);
        // Navigator.pop(context);
        break;
      case "SignOut":
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => Navigate()));
        try {
          // Sign out from Firebase
          await FirebaseAuth.instance.signOut();

          // Sign out from Google
          await googleSignInController.signOutFromGoogle();

          // Display a snackbar for sign-out
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Signed out successfully'),
              duration: Duration(seconds: 2),
            ),
          );
        } catch (e) {
          // Handle any exceptions that might occur during sign-out
          print('Error during sign-out: $e');
        }

        break;
      case "Notifications":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StoreMessage()));

        // NewStoredPage(storedMessages: storedMessages)));
        break;
      // Add more cases for other icons as needed
      default:
        // Navigate to a default page or handle unknown cases
        break;
    }
  }
}

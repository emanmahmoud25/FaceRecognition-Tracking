import 'package:flutter/material.dart';
import 'package:project/constants/utils_rive.dart';
import 'package:rive/rive.dart';

import '../../../Models/models_rive_assets.dart';
import 'Component_AnimatedBar.dart';

class MMainPageWithNavBottmBar extends StatefulWidget {
  const MMainPageWithNavBottmBar({super.key});

  @override
  State<MMainPageWithNavBottmBar> createState() =>
      _MMainPageWithNavBottmBarState();
}

class _MMainPageWithNavBottmBarState extends State<MMainPageWithNavBottmBar> {
  // late SMIBool searchTigger;
  RiveAsset selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //!to make all cards show show from bottomnav
      // resizeToAvoidBottomInset: false,
      // extendBody: true,
      //! to call the component when we click on animated icons
      body: Center(child: getElementBasedOnSelection()),
      // body: const General(),
      //!
      bottomNavigationBar: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 28, 26, 26),
            borderRadius: BorderRadius.all(Radius.circular(22))),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          //to make icon aniamtion and play it
          ...List.generate(
              bottomNavs.length,
              (index) => GestureDetector(
                    onTap: () {
                      //to make implemente that Opacity Change to Buttons
                      if (bottomNavs[index] != selectedBottomNav) {
                        setState(() {
                          selectedBottomNav = bottomNavs[index];
                        });
                      }
                      //X searchTigger.change(true);
                      //to make animation Duration for icons
                      bottomNavs[index].input!.change(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        bottomNavs[index].input!.change(false);
                      });
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //to make blue line above of animation icons
                        AnimatedBar(
                            isActive: bottomNavs[index] == selectedBottomNav),
                        SizedBox(
                          height: 36,
                          width: 36,
                          //to play icon animation we use StateMachineName and findSMI name to play from image from arive website when we make edit on photo
                          child: Opacity(
                            opacity: bottomNavs[index] == selectedBottomNav
                                ? 1
                                : 0.5,
                            child: RiveAnimation.asset(
                              //returns the first element in the iteration order, equivalent to this.elementAt(0)
                              bottomNavs.first.src,
                              artboard: bottomNavs[index].artboard,
                              //X "assets/RiveAssets/icons.riv", //collection of icon in one photo animation
                              //X artboard: "SEARCH",
                              onInit: (artboard) {
                                StateMachineController? controller =
                                    RiveUtils.getRiveController(artboard,
                                        stateMachineName:
                                            // X "SEARCH_Interactivity"
                                            bottomNavs[index].stateMachineName);
                                //to make icon aniamtion and play it
                                //   X searchTigger =
                                bottomNavs[index].input =
                                    controller?.findSMI("active") as SMIBool;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
        ]),
      )),
    );
  }

//! Show this Components When We Click on Animated Iacons On NavBottomBar
// In this example, the getElementBasedOnSelection function is called after the build phase using addPostFrameCallback to navigate to the selected screen. Adjust the logic inside
  void onBottomNavTap(RiveAsset bottomNav) {
    setState(() {
      selectedBottomNav = bottomNav;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getElementBasedOnSelection();
    });
  }

  Widget getElementBasedOnSelection() {
    switch (selectedBottomNav.title) {
      case "Chat":
        return Text("Chat Screen"); // Replace with your Chat screen widget
      case "Search":
        return Text("Search Screen");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const SignUp()));
      // return Container();
      case "Timer":
        return Text("Timer Screen");
      case "Notifications":
        // return Text("Notifications Screen");
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => NotifyMessage(
          //               data: // pass the RemoteMessage instance here,
          //                   ModalRoute.of(context)!.settings.arguments
          //                       as RemoteMessage,
          //             )));
        });
        break;
      case "Profile":
        return Text("Profile Screen");
      default:
        return Container();
      // Default case, you can change it accordingly
    }
    return Container();
  }
}

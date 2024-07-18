import 'package:flutter/material.dart';
import 'package:project/Models/models_rive_assets.dart';
import 'package:project/constants/utils_rive.dart';
import 'package:project/screens/sideMenu/infoCard.dart';
import 'package:project/screens/sideMenu/sideMenuTile.dart';
import 'package:rive/rive.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  //!!! to call storedMessage
  // List<String> storedMessages = []; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconCard(
              name: 'User',
              profession: 'profession',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Browse".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ),
            // SideMenuTile()
            ...sideMenus.map(
              (menu) => SideMenuTile(
                menu: menu,
                riveonInit: (artboard) {
                  StateMachineController? controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: menu.stateMachineName);

                  if (controller != null) {
                    menu.input = controller.findSMI("active") as SMIBool;
                  } else {
                    // Handle the case where controller is null
                    print(
                        "########Error1: Unable to create StateMachineController.");
                  }
                },
                press: () {
                  if (menu.input != null) {
                    menu.input!.change(true);
                    Future.delayed(Duration(seconds: 2), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  } else {
                    // Handle the case where menu.input is null
                    print("*********Error1: SMIBool (menu.input) is null.");
                  }
                },
                isActive: selectedMenu == menu,
                // storedMessages: storedMessages, //! Pass the storedMessages list
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
              child: Text(
                "Account".toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white70),
              ),
            ),
            ...sideMenu2.map(
              (menu) => SideMenuTile(
                menu: menu,
                riveonInit: (artboard) {
                  print("Artboard: ${artboard.name}");

                  StateMachineController? controller =
                      RiveUtils.getRiveController(artboard,
                          stateMachineName: menu.stateMachineName);

                  if (controller != null) {
                    menu.input = controller.findSMI("active") as SMIBool;
                  } else {
                    // Handle the case where controller is null
                    print(
                        "########Error2: Unable to create StateMachineController.");
                  }
                },
                press: () {
                  if (menu.input != null) {
                    menu.input!.change(true);
                    Future.delayed(const Duration(seconds: 2), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });
                  } else {
                    // Handle the case where menu.input is null
                    print("stateMachineName: ${menu.stateMachineName}");

                    print("*********Error2: SMIBool (menu.input) is null.");
                  }
                },
                isActive: selectedMenu == menu,
                // storedMessages: storedMessages, //! Pass the storedMessages list
              ),
            ),
          ],
        )),
      ),
    );
  }
}

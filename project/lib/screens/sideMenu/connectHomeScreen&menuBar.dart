import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/constants/Colors.dart';
import 'package:project/constants/utils_rive.dart';
import 'package:project/screens/HomePage/MenuButton.dart';
import 'package:project/screens/HomePage/homeScreenWithOutBottmBar.dart';
import 'package:project/screens/sideMenu/Side_Menu.dart';
import 'package:rive/rive.dart';

class Home_MenuSide extends StatefulWidget {
  const Home_MenuSide({super.key});

  @override
  State<Home_MenuSide> createState() => _Home_MenuSideState();
}

class _Home_MenuSideState extends State<Home_MenuSide>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleanimation;

  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleanimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor2,
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.fastOutSlowIn,
              width: 288,
              left: isSideMenuClosed ? -288 : 0,
              height: MediaQuery.of(context).size.height,
              child: SideMenu()),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
                offset: Offset(animation.value * 265, 0),
                child: Transform.scale(
                    scale: scaleanimation.value,
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        child: HomeScreen()))),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            //Curves.fastOutSlowIn is a predefined curve that starts quickly, slows down in the middle, and then ends quickly. It's often used for animations that need to feel dynamic and responsive.
            top: 12,
            left: isSideMenuClosed ? 0 : 220,
            child: MenuBtn(
              riveOnInit: (artboard) {
                StateMachineController? controller =
                    RiveUtils.getRiveController(artboard,
                        stateMachineName: "State Machine");
                isSideBarClosed = controller?.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
              press: () {
                isSideBarClosed.value = !isSideBarClosed.value;
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = isSideBarClosed.value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

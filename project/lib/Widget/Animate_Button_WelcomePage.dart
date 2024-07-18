import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required RiveAnimationController btnAnimationController,
    required this.press,
    required RiveAnimationController btnAnimationColtroller,
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   _btnAnimationController.isActive = true;
      // },
      onTap: press,
      child: SizedBox(
          height: 64,
          width: 260,
          child: Stack(children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [_btnAnimationController],
            ),
            // Lottie.asset('assets/Lottie/Animation - 1701075717708.json',
            //     height: 900, width: 900),
            const Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.arrow_right),
                  SizedBox(width: 8),
                  Text(
                    "Start",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}

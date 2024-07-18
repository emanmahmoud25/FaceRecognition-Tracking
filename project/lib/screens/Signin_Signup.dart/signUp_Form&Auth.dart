import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Controller/signUpCntroller.dart';
import 'package:project/Widget/TextFormField.dart';
import 'package:project/constants/utils_rive.dart';
import 'package:rive/rive.dart';

import '../../constants/Colors.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
//we want check if textfield is empty or not
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  SignUpController _signUpController = SignUpController();

  //want to show the loading once the user tab on signin button
  bool isShowLoading = false;
  bool isShowconfetti = false;
  //check animation
  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;
  late SMITrigger confetti;
  //StateMachineController is some thing in rive.app to make animation speed or move
  //this code to play this animations (check ,error ,reset)
//for animation Duration and check form if empty or not
  //if every thing looks good it shows the sucess animation
  //  In your signIn method, you're using Future.delayed to execute some code after a delay. If the widget is disposed during that delay, calling setState will result in the mentioned error.
// By adding the if (mounted) checks before each setState, you ensure that the widget is still in the widget tree before trying to modify its state. This should prevent the setState called after dispose error.
  void signIn(BuildContext context) {
    if (mounted) {
      setState(() {
        isShowLoading = true;
        isShowconfetti = true;
      });
    }
    Future.delayed(Duration(seconds: 2), () {
      if (mounted) {
        if (_formkey.currentState!.validate()) {
          confetti.fire();
          Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                isShowLoading = false;
              });
            }
          });
        } else {
          // or error animation
          error.fire();
          Future.delayed(Duration(seconds: 2), () {
            if (mounted) {
              setState(() {
                isShowLoading = false;
              });
            }
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form_signin(context),

        //there is 3 types of this animation check ,error ,reset
        //if all right must be get sucees else get error
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  "assets/RiveAssets/check.riv",
                  onInit: (artboard) {
                    StateMachineController? controller =
                        RiveUtils.getRiveController(artboard);
                    check = controller?.findSMI("Check") as SMITrigger;
                    error = controller?.findSMI("Error") as SMITrigger;
                    reset = controller?.findSMI("Reset") as SMITrigger;
                  },
                ),
              )
            : SizedBox(),

        // to see congrates animation if sucess
        isShowconfetti
            ? CustomPositioned(
                child: Transform.scale(
                  scale: 7,
                  child: RiveAnimation.asset(
                    "assets/RiveAssets/confetti.riv",
                    onInit: (artboard) {
                      StateMachineController? controller =
                          RiveUtils.getRiveController(artboard);
                      confetti = controller?.findSMI("Trigger explosion")
                          as SMITrigger;
                    },
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }

//Form Content
  Form Form_signin(BuildContext context) {
    return Form(
      //we want check if textfield is empty or not

      key: _formkey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        //!  DynamicTextFormField

        const Padding(
          padding: EdgeInsets.only(left: 11),
          child:
              Text("User Name", style: TextStyle(color: AppColors.TextColor)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DynamicTextFormField(
              controller: _signUpController.usernameController,
              decoration: InputDecoration(),
              onSaved: (username) {},
              validator: (value) =>
                  value.isEmpty ? "Please enter a value" : null,
              iconPath: "assets/icons/email.svg",
              hinttext: 'enter your uername',
              isNumber: false,
            )),

        const Padding(
          padding: EdgeInsets.only(left: 11),
          child: Text("Email", style: TextStyle(color: AppColors.TextColor)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            //!  DynamicTextFormField

            child: DynamicTextFormField(
              controller: _signUpController.emailController,
              decoration: InputDecoration(),
              onSaved: (email) {},
              validator: (value) =>
                  value.isEmpty ? "Please enter a value" : null,
              iconPath: "assets/icons/email.svg",
              hinttext: 'enter your email',
              isNumber: false,
            )),
        const Padding(
          padding: EdgeInsets.only(left: 11),
          child: Text("Password", style: TextStyle(color: AppColors.TextColor)),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: DynamicTextFormField(
              controller: _signUpController.passwordController,
              obsecureText: true,
              decoration: InputDecoration(),
              onSaved: (password) {},
              validator: (value) =>
                  value.isEmpty ? "Please enter a value" : null,
              iconPath: "assets/icons/password.svg",
              hinttext: 'enter your password',
              isNumber: false,
            )),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: ElevatedButton.icon(
            onPressed: () async {
              signIn(context);
              _signUpController.signUpUser(context);
              //if pass sucess go to next page
              //firt once user tab the sign in button it show the loading
              // signIn(context);
              ////////////////////////////////////////////////////////////////////////////! Auth Sign Up

              // try {
              //   final credential =
              //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
              //     email: _emailController.text,
              //     password: _passwordController.text,
              //   );
              //   confetti.fire();
              //   await Future.delayed(Duration(seconds: 2));
              //   Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: ((context) => const HomeScreen())));
              // } on FirebaseAuthException catch (e) {
              //   if (e.code == 'weak-password') {
              //     print('********The password provided is too weak.');
              //     AwesomeDialog(
              //       context: context,
              //       dialogType: DialogType.error,
              //       animType: AnimType.rightSlide,
              //       title: 'Error',
              //       desc: 'The password provided is too weak.',
              //       btnCancelOnPress: () {},
              //       btnOkOnPress: () {},
              //     ).show();
              //     // error.fire();
              //   } else if (e.code == 'email-already-in-use') {
              //     print('*********The account already exists for that email.');
              //     AwesomeDialog(
              //       context: context,
              //       dialogType: DialogType.error,
              //       animType: AnimType.rightSlide,
              //       title: 'Error',
              //       desc: 'The account already exists for that email..',
              //       btnCancelOnPress: () {},
              //       btnOkOnPress: () {},
              //     ).show();
              //     // error.fire();
              //   }
              // } catch (e) {
              //   print(e);
              // }
//!/////////////////////////////////////////////////////////////////////////////////
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF77D8E),
                minimumSize: const Size(double.infinity, 56),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ))),
            icon: const Icon(CupertinoIcons.arrow_right,
                color: AppColors.RawColoronButton),
            label: const Text("Sign Up"),
          ),
        )
      ]),
    );
  }
}

//custom Posited for Animation
class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, required this.child, this.size = 100});
  final Widget child;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Column(
      children: [
        const Spacer(),
        SizedBox(height: size, width: size, child: child),
        Spacer(flex: 2),
      ],
    ));
  }
}

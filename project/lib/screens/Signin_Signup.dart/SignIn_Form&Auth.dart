import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/Widget/TextFormField.dart';
import 'package:project/constants/utils_rive.dart';
import 'package:rive/rive.dart';

import '../../Controller/login_controller.dart';
import '../../constants/Colors.dart';

class SigningForm extends StatefulWidget {
  const SigningForm({
    super.key,
  });

  @override
  State<SigningForm> createState() => _SigningFormState();
}

class _SigningFormState extends State<SigningForm> {
//we want check if textfield is empty or not
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final LoginController loginController = LoginController();
  // Function for handling "Forget Password" logic

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
  // check.fire();
  //In your signIn method, you're using Future.delayed to execute some code after a delay. If the widget is disposed during that delay, calling setState will result in the mentioned error.
//By adding the if (mounted) checks before each setState, you ensure that the widget is still in the widget tree before trying to modify its state. This should prevent the setState called after dispose error.
  //after closing it we want to show congrates animation
  // confetti.fire();
  //once all Success we will navigate to Next Screen
  //there is 3 types of this animation check ,error ,reset
//if all right must be get sucees else get error
  void signIn(BuildContext context) {
    if (mounted) {
      setState(() {
        isShowLoading = true;
        isShowconfetti = true;
      });
    }
    Future.delayed(Duration(seconds: 1), () {
      if (mounted) {
        if (_formkey.currentState!.validate()) {
          // confetti.fire();
          Future.delayed(Duration(seconds: 1), () {
            if (mounted) {
              setState(() {
                isShowLoading = false;
              });
            }
          });
        } else {
          // or error animation
          // error.fire();
          Future.delayed(Duration(microseconds: 1), () {
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
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Email", style: TextStyle(color: AppColors.TextColor)),
          Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              //!  DynamicTextFormField
              child: DynamicTextFormField(
                controller: loginController.emailController,
                decoration: InputDecoration(),
                onSaved: (email) {},
                validator: (value) =>
                    value.isEmpty ? "Please enter a value" : null,
                iconPath: "assets/icons/email.svg",
                hinttext: 'enter your email',
                isNumber: false,
              )),
          const Text("Password", style: TextStyle(color: AppColors.TextColor)),
          Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              //!  DynamicTextFormField
              child: DynamicTextFormField(
                controller: loginController.passwordController,
                decoration: InputDecoration(),
                onSaved: (password) {},
                validator: (value) =>
                    value.isEmpty ? "Please enter a value" : null,
                iconPath: "assets/icons/password.svg",
                hinttext: 'enter your password',
                isNumber: false,
              )),
          InkWell(
            onTap: () async {
              // ignore: unrelated_type_equality_checks
              if (loginController.emailController.text == "") {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: ' Please  Write Your  Email',
                  desc: 'Please write your e-mail and then click',
                  btnOkOnPress: () {},
                ).show();
                return;
              }
              // SigninForm.forgetPassword(context);

              // if (loginController.emailController.text ==
              //     loginController.LoginUser(context)) {}

              try {
                await loginController.resetPassword(context);
                // ignore:use_build_context_synchronously
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.rightSlide,
                  title: 'Check Your Email',
                  desc: 'A password reset link has been sent to your email',
                  btnOkOnPress: () {},
                ).show();
              } catch (e) {
                // ignore: use_build_context_synchronously
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  animType: AnimType.rightSlide,
                  title: 'Error',
                  desc: 'Please Enter Corrext Email',
                  btnOkOnPress: () {},
                ).show();
              }
            },
            //    if (loginController.LoginUser(context) != null) {
            //   try {
            //     await loginController.resetPassword(context);
            //     // ignore:use_build_context_synchronously
            //     AwesomeDialog(
            //       context: context,
            //       dialogType: DialogType.error,
            //       animType: AnimType.rightSlide,
            //       title: 'Error',
            //       desc: 'A password reset link has been sent to your email',
            //       btnOkOnPress: () {},
            //     ).show();
            //   } catch (e) {
            //     AwesomeDialog(
            //       context: context,
            //       dialogType: DialogType.error,
            //       animType: AnimType.rightSlide,
            //       title: 'Error',
            //       desc: 'Please Enter Corrext Email',
            //       btnOkOnPress: () {},
            //     ).show();
            //   }
            // }

            child: Container(
              alignment: Alignment.topRight,
              child: const Text(
                "Forget Password ?",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 20),
            child: ElevatedButton.icon(
              onPressed: () async {
                //if pass sucess go to next page
                //firt once user tab the sign in button it show the loading
                signIn(context);
                loginController.LoginUser(context);
                //!Authentication
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF77D8E),
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
              label: const Text("Sign In"),
            ),
          )
        ]),
      ),
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

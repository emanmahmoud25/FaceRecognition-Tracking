import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/constants/Colors.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify = "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var phone = "";
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+20";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   "assets/Backgrounds/Spline.png",
              //   width: 150,
              //   height: 150,
              // ),

              Container(
                width: 170,
                height: 170,
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.buttonColor,
                ),
                //!! to make photo as circle
                child: ClipOval(
                  child: SvgPicture.asset(
                    "assets/Backgrounds/12291223_Wavy_Tech-28_Single-10.svg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Phone Registration",
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins"),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Add your phone number ,we'll send you a verification code so we know you are real",
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(135, 79, 79, 79)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: countrycode,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countrycode.text + phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      MyPhone.verify = verificationId;
                      Navigator.pushNamed(context, "otp");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF77D8E),
                    minimumSize: const Size(340, 54),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                    ))),
                icon: const Icon(CupertinoIcons.arrow_right,
                    color: AppColors.RawColoronButton),
                label: const Text("Send the code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

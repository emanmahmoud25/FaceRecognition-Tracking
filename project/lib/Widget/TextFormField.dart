// import 'package:flutter/material.dart';

// class TextForm extends StatelessWidget {
//   //final Widget? suffixIcon;
//   final String hinttext;
//   final String label;
//   final IconData? icon;
//   final TextEditingController? mycontroller;
//   final String? Function(String?) valid;
//   final bool isNumber;
//   final bool? obsecureText;
//   final void Function()? onTapIcon;
//   const TextForm(
//       {Key? key,
//       required this.hinttext,
//       required this.label,
//       required this.icon,
//       required this.mycontroller,
//       required this.valid,
//       required this.isNumber,
//       this.obsecureText,
//       this.onTapIcon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 20),
//       child: TextFormField(
//         //to make keyboard numbers only
//         keyboardType: isNumber
// ? TextInputType.numberWithOptions(decimal: true)
//             : TextInputType.text,
//         validator: valid,
//         controller: mycontroller,
//         obscureText:
//             obsecureText == null || obsecureText == false ? false : true,
//         // true mean it is hide
//         //false mean it is show
//         decoration: InputDecoration(
//             hintText: hinttext,
//             // filled: true,
//             // fillColor: Color.fromARGB(255, 234, 255, 254),
//             hintStyle: const TextStyle(fontSize: 14),
//             floatingLabelBehavior: FloatingLabelBehavior.always,
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
//             label: Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 9),
//                 child: Text(label)),
//             prefixIcon: InkWell(child: Icon(icon), onTap: onTapIcon),
//                 // OutlineInputBorder(borderRadius: BorderRadius.circular(30)
//                  )),
//       );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DynamicTextFormField extends StatelessWidget {
  final InputDecoration decoration;
  final TextEditingController controller;

  final Null Function(dynamic email) onSaved;
  final String? Function(dynamic value) validator;
  final String iconPath;
  final bool? isNumber;

  final bool? obsecureText;

  final String hinttext;
  const DynamicTextFormField({
    Key? key,
    required this.decoration,
    required this.onSaved,
    required this.validator,
    required this.iconPath,
    this.obsecureText,
    required this.hinttext,
    required this.isNumber,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      keyboardType: (isNumber ?? false)
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter a value";
        }
        return null;
      },

      // obscureText: obsecureText == null || obsecureText == false ? false : true,
      onSaved: onSaved, // Use the provided onSaved function
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: TextStyle(color: Color.fromARGB(255, 174, 174, 174)),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SvgPicture.asset(iconPath),
        ),
      ),
    );
  }
}

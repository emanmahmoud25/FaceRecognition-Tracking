import 'package:flutter/Material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTab,
  }) : super(key: key);

  final String text;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
      ),
      onPressed: onTab,
      child: Text(text),
    );
  }
}

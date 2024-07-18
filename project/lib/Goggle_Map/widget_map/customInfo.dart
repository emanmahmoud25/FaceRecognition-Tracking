import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';

class Custominfoo extends StatelessWidget {
  final CustomInfoWindowController customInfoWindowController;

  const Custominfoo({
    super.key,
    required this.customInfoWindowController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInfoWindow(
      controller: customInfoWindowController,
      height: 150,
      width: 200,
      offset: 40,
    );
  }
}

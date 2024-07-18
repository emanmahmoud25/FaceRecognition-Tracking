import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveUtils {
  static StateMachineController? getRiveController(Artboard artboard,
      {stateMachineName = "State Machine 1"}) {
    try {
      StateMachineController? controller =
          StateMachineController.fromArtboard(artboard, stateMachineName);

      if (controller != null) {
        artboard.addController(controller);
        return controller;
      } else {
        // Handle the case where controller is null
        throw FlutterError("Unable to create StateMachineController.");
      }
    } catch (e, stackTrace) {
      // Catch any exceptions during controller creation
      print("Error during StateMachineController creation: $e\n$stackTrace");
      return null;
    }
  }
}

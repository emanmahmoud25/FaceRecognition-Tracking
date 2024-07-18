import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:project/Camera_auth.dart/camera.dart';
import 'package:project/Camera_auth.dart/locator.dart';

class FaceRecognition extends StatefulWidget {
  const FaceRecognition({Key? key}) : super(key: key);

  @override
  State<FaceRecognition> createState() => _FaceRecognitionState();
}

class _FaceRecognitionState extends State<FaceRecognition> {
  late CameraService _cameraService;
  int direction = 0;
  bool _isInitialized = false;
  String _errorMessage = '';

  @override
  void initState() {
    _cameraService = locator<CameraService>();
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    try {
      await _cameraService.initialize(direction);
      setState(() {
        _isInitialized = true;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _isInitialized = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  void dispose() {
    _cameraService.dispose();
    super.dispose();
  }

  void toggleCameraDirection() {
    setState(() {
      direction = direction == 0 ? 1 : 0;
      startCamera(direction);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error: $_errorMessage',
            style: TextStyle(color: Colors.red, fontSize: 20),
          ),
        ),
      );
    }

    if (_isInitialized &&
        _cameraService.cameraController!.value.isInitialized) {
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(_cameraService.cameraController!),
            GestureDetector(
              onTap: () {
                startCamera(direction == 0 ? 1 : 0);
              },
              child:
                  button(Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
            ),
            GestureDetector(
              onTap: () {
                _cameraService.cameraController!
                    .takePicture()
                    .then((XFile? file) {
                  if (mounted) {
                    if (file != null) {
                      print("Picture saved to ${file.path}");
                    }
                  }
                });
              },
              child: button(Icons.camera_alt_outlined, Alignment.bottomCenter),
            ),
            const Align(
              alignment: AlignmentDirectional.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "My Camera",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}

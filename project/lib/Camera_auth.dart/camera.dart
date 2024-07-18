import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart'
    as perm; // Alias for permission_handler package

class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  Future<void> initialize(int direction) async {
    if (_cameraController != null) return;

    // Request camera permission
    final perm.PermissionStatus status = await perm.Permission.camera.request();
    if (status != perm.PermissionStatus.granted) {
      throw Exception("Camera permission denied");
    }

    CameraDescription description = await _getCameraDescription(direction);
    await _setupCameraController(description: description);
  }

  Future<CameraDescription> _getCameraDescription(int direction) async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
        camera.lensDirection ==
        (direction == 0
            ? CameraLensDirection.front
            : CameraLensDirection.back));
  }

  Future<void> _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
  }

  Future<void> dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}

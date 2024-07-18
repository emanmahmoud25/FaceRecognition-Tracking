import 'package:get_it/get_it.dart';
import 'package:project/Camera_auth.dart/camera.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<CameraService>(() => CameraService());
}

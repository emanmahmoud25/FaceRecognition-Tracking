// Create aModel For content in Home Page
import 'dart:ui';

class Data {
  final String title, description, iconSrc;
  final Color bgColor;
  final List<String>? AvatarImages;
//constants information in constructure
  Data({
    required this.title,
    this.description = "Here I Write All Detections From Camera",
    this.iconSrc = "assets/icons/camera.png",
    this.bgColor = const Color(0xFF7553F6),
    this.AvatarImages,
  });
}

//when i need to change some data in constructure (CardOne)
List<Data> Alldata = [
  Data(
    title: "Face Recognition",
    description: "Customize your face through camera and photo gallery",
    AvatarImages: [
      "assets/avaters/general 4.svg",
      "assets/avaters/general 5.svg",
      "assets/avaters/general 6.svg"
    ],
    iconSrc: "assets/icons/face-recognition.svg",
  ),
  Data(
    title: "ShowData",
    description: "All data about the people captured by the camera",
    AvatarImages: [
      "assets/avaters/general 4.svg",
      "assets/avaters/general 5.svg",
      "assets/avaters/general 6.svg"
    ],
    iconSrc: "assets/icons/103465_data_privacy_icon.svg",
    bgColor: Color.fromARGB(255, 255, 178, 188),
  ),
];
//when i need to change some data in constructure(CardTwo)
List<Data> recentData = [
  Data(title: "CameraEsp1", description: "13"),
  Data(
      title: "CameraEsp2",
      bgColor: Color.fromARGB(255, 255, 178, 188),
      iconSrc: "assets/icons/camera.png"),
  Data(title: "UploadVideo"),
];

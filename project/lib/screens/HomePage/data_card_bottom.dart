// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:project/Camera_auth.dart/camer_auth.dart';
import 'package:project/Camera_auth.dart/espCamera/espCamera.dart';
import 'package:project/Models/Card_HomePage.dart';
import 'package:project/UploadImagesToServer/uploadVideo.dart';

class SecondryCardData extends StatelessWidget {
  const SecondryCardData({
    super.key,
    required this.data,
  });
  final Data data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (data.title == "CameraEsp1") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StreamCameraScreen()));
        } else if (data.title == "CameraEsp2") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FaceRecognition()));
        } else if (data.title == "UploadVideo") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      VideoUploadScreen())); // Replace ThirdScreen with the screen you want to navigate to
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
              color:
                  // AppColors.purple_color,
                  data.bgColor,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(data.title,
                        //"State Machine",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600)),
                    Text(
                      "Just click",
                      style: TextStyle(color: Colors.white60, fontSize: 16),
                    )
                  ],
                ),
              ),
              // to draw  whiteLine after icon
              const SizedBox(
                  height: 40, child: VerticalDivider(color: Colors.white70)),
              Image.asset(
                // Provide the path to your PNG image asset
                data.iconSrc,
                // You can adjust height, width, and fit based on your requirements
                height: 40,
                width: 40,
                fit: BoxFit.contain,
              ),
            ],
          )),
    );
  }
}

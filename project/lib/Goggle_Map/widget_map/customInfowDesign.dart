import 'package:flutter/material.dart';

class CustomInfoMarker extends StatelessWidget {
  final String imagePath;
  final String locationName;
  final String description;

  const CustomInfoMarker({
    super.key,
    required this.imagePath,
    required this.locationName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 170,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 246, 166),
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fitWidth,
                  filterQuality: FilterQuality.high,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 3, left: 7, right: 7),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      locationName,
                      style: const TextStyle(
                          fontFamily: "Intel",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      maxLines: 5,
                      //  overflow: TextOverflow.fade,
                      // softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 3, left: 10, right: 5, bottom: 3),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: "Intel",
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

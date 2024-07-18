import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/ServerData/DataFromServer(AllPages).dart';
import 'package:project/UploadImagesToServer/function.dart';

import '../../Models/Card_HomePage.dart';

class DataCardOne extends StatelessWidget {
  const DataCardOne({
    super.key,
    required this.data,
  });
  final Data data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (data.title == "Face Recognition") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageUploadScreen(),
              ),
            );
          } else if (data.title == "ShowData") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DataFromServer(),
              ),
            );
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 25),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          height: 280,
          width: 260,
          decoration: BoxDecoration(
              // color: Color(0xFF7553F6)
              color: data.bgColor,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    // "General & All Detection",
                    data.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      // "Here I Write All Detections From Camera",
                      data.description,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 247, 246, 246),
                          fontSize: 18),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: List.generate(
                        3,
                        (index) => Transform.translate(
                            offset: Offset((-11 * index).toDouble(), 0),
                            child: CircleAvatar(
                              radius: 15,
                              child:
                                  SvgPicture.asset(data.AvatarImages![index]),
                            ))),
                  )
                ],
              ),
            ),
            SvgPicture.asset(
                // "assets/icons/ios.svg"
                data.iconSrc)
          ]),
        ));
  }
}

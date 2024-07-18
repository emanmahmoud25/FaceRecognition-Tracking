import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/ServerData/model.dart';
import 'package:project/ServerData/widget/pickimagewidget.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required XFile? image,
    required this.user,
    required this.date,
    required this.time,
    required this.similarity, // Added similarity parameter
  })  : _image = image,
        super(key: key);

  final XFile? _image;
  final User user;
  final String date;
  final String time;
  final String similarity; // Added similarity

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        color: Color.fromARGB(255, 232, 244, 252),
        child: ListTile(
          leading: SizedBox(
            width: 80,
            height: 90,
            child: _image != null
                ? Image.file(
                    File(_image!.path),
                    fit: BoxFit.cover,
                  )
                : pickimagewidget(imageUrl: user.imageurl),
          ),
          title: Text(
            'id :${user.id}\n${user.name}  ',
            style: TextStyle(
              color: Color.fromARGB(255, 116, 56, 255),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "City: ${user.address.city}\nStreet: ${user.address.street}\nLat: ${user.address.geo.lat}   Lng: ${user.address.geo.lng}",
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 8),
              Text(
                'Date: $date\nTime: $time\nSimilarity: $similarity', // Display similarity
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

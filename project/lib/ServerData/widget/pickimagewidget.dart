import 'dart:io';

import 'package:flutter/material.dart';
//! cases to pick images from device

class pickimagewidget extends StatelessWidget {
  const pickimagewidget({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith("http")) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
      );
    } else if (imageUrl.isNotEmpty && File(imageUrl).existsSync()) {
      return Image.file(
        File(imageUrl),
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        color: Colors.grey, // Placeholder color if image is not available
      );
    }
  }
}

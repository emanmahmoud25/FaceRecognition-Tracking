import 'package:flutter/material.dart';

class CustomInfoWindowContent extends StatelessWidget {
  final String title;
  final String location;

  CustomInfoWindowContent({required this.title, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Adjust the width as needed
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Location: $location',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 5),
          // Add more content widgets here if needed
        ],
      ),
    );
  }
}

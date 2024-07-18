import 'package:flutter/material.dart';
import 'package:project/ServerData/createpage.dart';

class floatingButton extends StatelessWidget {
  const floatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePage()), // Instantiate CreatePage
        );
      },
      child: Icon(Icons.add),
    );
  }
}

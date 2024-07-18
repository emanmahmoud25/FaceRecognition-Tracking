import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/ServerData/FunctionsRequest.dart';
import 'package:project/ServerData/model.dart';
import 'package:project/ServerData/widget/Card.dart';

Dismissible DeleteCardAndMoveLeftAndRight(User user, BuildContext context) {
  Repository repository = Repository();
  XFile? _image; // Declare _image here

  return Dismissible(
    key: Key(user.id.toString()),
    direction: DismissDirection.endToStart,
    background: Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: const Icon(Icons.delete),
    ),
    confirmDismiss: (direction) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Data'),
            content: Text('Are You Sure To Delete Data'),
            actions: [
              TextButton(
                onPressed: () async {
                  bool response = await repository.deleteData(user.id);
                  if (response) {
                    Navigator.pop(context, true);
                  } else {
                    Navigator.pop(context, false);
                  }
                },
                child: Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text('No'),
              )
            ],
          );
        },
      );
    },
    child: CardWidget(
      image: _image,
      user: user,
      date: user.date,
      time: user.time,
      similarity: user.similarity,
    ),
  );
}

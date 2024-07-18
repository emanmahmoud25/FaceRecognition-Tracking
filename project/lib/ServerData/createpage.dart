import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/ServerData/FunctionsRequest.dart';
import 'package:project/ServerData/model.dart';
import 'package:project/ServerData/widget/snackBar.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final similarityController = TextEditingController(); // Similarity controller

  Repository repository = Repository();

  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    XFile? pickedImage = await ImagePicker().pickImage(source: source);

    setState(() {
      _image = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                //! Options Camera & Gallery With Alert
                ElevatedButton.icon(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Choose an option"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.camera),
                                label: const Text("Camera"),
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.photo),
                                label: const Text("Gallery"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.add_a_photo),
                  label: const Text("Choose Photo"),
                ),
                //! size when i choose Image
                _image != null
                    ? Image.file(
                        File(_image!.path),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      )
                    : Container(),
                const SizedBox(height: 16),
                //! Text Fields to Create
                TextField(
                  controller: idController,
                  decoration: InputDecoration(hintText: "id"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: "name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cityController,
                  decoration: InputDecoration(hintText: "city"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: streetController,
                  decoration: InputDecoration(hintText: "street"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: latController,
                  decoration: InputDecoration(hintText: "latitude"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: longController,
                  decoration: InputDecoration(hintText: "longitude"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
                  decoration: InputDecoration(hintText: "date"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(hintText: "time"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: similarityController, // Similarity text field
                  decoration: InputDecoration(
                      hintText: "similarity"), // Similarity hint text
                ),
                const SizedBox(height: 8),

                //! show  Data when i click submit
                ElevatedButton(
                  onPressed: () async {
                    int? id;
                    try {
                      id = idController.text.isNotEmpty
                          ? int.parse(idController.text)
                          : null;
                    } catch (e) {
                      // Handle the case where the input is not a valid integer
                      showSnackbar(
                          context, 'Invalid id input: ${idController.text}');
                      return;
                    }

                    if (id != null) {
                      bool response = await repository.createData(
                        id,
                        nameController.text,
                        Address(
                          street: streetController.text,
                          city: cityController.text,
                          geo: Geo(
                            lat: latController.text,
                            lng: longController.text,
                          ),
                        ),
                        _image != null ? _image!.path : "",
                        dateController.text,
                        timeController.text,
                        similarityController.text, // Pass similarity value
                      );
                      if (response) {
                        Navigator.popAndPushNamed(context, 'DataFromServer');
                      } else {
                        showSnackbar(context, repository.errorMessage);
                        print(repository.errorMessage);
                      }
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

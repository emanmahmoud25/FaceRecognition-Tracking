import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project/ServerData/FunctionsRequest.dart';
import 'package:project/ServerData/model.dart';

class UpdatePageFromServer extends StatefulWidget {
  final User user;
  // final String similarity; // Added similarity parameter
  const UpdatePageFromServer({required this.user, Key? key}) : super(key: key);

  @override
  State<UpdatePageFromServer> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePageFromServer> {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();
  final dateController =
      TextEditingController(); // New TextEditingController for date
  final timeController =
      TextEditingController(); // New TextEditingController for time
  final similarityController =
      TextEditingController(); // New TextEditingController for similarity

  late User user;
  Repository repository = Repository();

  @override
  void initState() {
    super.initState();
    user = widget.user;
    // Initialize date, time, and similarity fields if available
    dateController.text = user.date;
    timeController.text = user.time;
    similarityController.text = user.similarity;
    // .text =
    // widget.similarity; // Initialize similarity controller with passed value
  }

  @override
  void dispose() {
    idController.dispose();
    nameController.dispose();
    cityController.dispose();
    streetController.dispose();
    latController.dispose();
    longController.dispose();
    dateController.dispose(); // Dispose date controller
    timeController.dispose(); // Dispose time controller
    similarityController.dispose(); // Dispose similarity controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as List<dynamic>;
    // Initialize text fields with data from arguments if available
    if (args[1].isNotEmpty) {
      nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      cityController.text = args[2];
    }
    if (args[3].isNotEmpty) {
      streetController.text = args[3];
    }
    if (args[4].isNotEmpty) {
      latController.text = args[4];
    }
    if (args[5].isNotEmpty) {
      longController.text = args[5];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 152,
                  child: CircleAvatar(
                    radius: 150,
                    backgroundImage: _buildImageWidget(user.imageurl),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: "name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(hintText: "city"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(hintText: "street"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: latController,
                  decoration: const InputDecoration(hintText: "latitude"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: longController,
                  decoration: const InputDecoration(hintText: "longitude"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(hintText: "Date"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: timeController,
                  decoration: const InputDecoration(hintText: "Time"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: similarityController,
                  decoration: const InputDecoration(hintText: "Similarity"),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      bool response = await repository.UpdatePage(
                        args[0].toString(),
                        nameController.text,
                        Address(
                          street: streetController.text,
                          city: cityController.text,
                          geo: Geo(
                            lat: latController.text,
                            lng: longController.text,
                          ),
                        ),
                        dateController.text,
                        timeController.text,
                        similarityController
                            .text, // Use similarity value when updating data
                      );

                      if (response) {
                        print("Data successfully updated!");
                        Navigator.popAndPushNamed(context, 'DataFromServer');
                      } else {
                        print("Failed to update data");
                        throw Exception('Failed to Update Data');
                      }
                    } catch (e) {
                      print("Exception during update: $e");
                      // Handle exception, show error message, or log it
                    }
                  },
                  child: const Text("Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ImageProvider<Object>? _buildImageWidget(String imageUrl) {
    if (imageUrl.startsWith("http")) {
      return NetworkImage(imageUrl);
    } else if (imageUrl.isNotEmpty && File(imageUrl).existsSync()) {
      return FileImage(File(imageUrl));
    } else {
      return const AssetImage(
          'assets/icons/profile_img.png'); // Provide a default image path
    }
  }
}

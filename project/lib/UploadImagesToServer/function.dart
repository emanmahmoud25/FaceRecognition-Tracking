import 'dart:io';
import 'dart:typed_data';

import 'package:azblob/azblob.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _textInputController =
      TextEditingController(); //! Add text input controller

  @override
  void dispose() {
    _textInputController.dispose(); //!! Dispose the text input controller
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  //! upload image alone
  //! this is  method to upload from Azure Storage
  Future uploadImageToAzure(BuildContext context) async {
    try {
      String fileName = basename(_image!.path);
      // read file as Uint8List
      Uint8List content = await _image!.readAsBytes();

      var storage = AzureStorage.parse(
          'DefaultEndpointsProtocol=https;AccountName=dataset7;AccountKey=yQc8xFTR6LdfUSg6J19C0Z6DhzrgrS9rnjT6QkA+WPl5QNAGTtrFP84a7prOkXSQUziyXi1Q1VYq+ASt5vURfQ==;EndpointSuffix=core.windows.net');
      String container = "newcriminal";
      // get the mine type of the file
      String? contentType = lookupMimeType(fileName);
      await storage.putBlob('/$container/$fileName',
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.blockBlob);
      print("done");
      Fluttertoast.showToast(
          msg: "Image uploaded successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } on AzureStorageException catch (ex) {
      print(ex.message);
      Fluttertoast.showToast(
          msg: "Failed to upload image. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (err) {
      print(err);
      Fluttertoast.showToast(
          msg: "An error occurred. Please try again.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

//! name of normal image as json (upload image upload the image without converting it to Base64)
    // Future uploadImageAndTextToAzure(BuildContext context) async {
    //   try {
    //     if (_image == null) {
    //       // Show a message or handle the case where no image is selected
    //       return;
    //     }
    //     String fileName = basename(_image!.path); // Get the file name
    //     String text = _textInputController.text; // Get text input value
    //     var storage = AzureStorage.parse(
    //       'DefaultEndpointsProtocol=https;AccountName=projectoutlaw;AccountKey=SiJj1ms0Z5XbuJiTFkq1/3ukXkrBITRDwI6aA9d28+njyDuNf+mcqBRRhBYU1aijE9isvF92QH2W+ASt33s7Ow==;EndpointSuffix=core.windows.net',
    //     );
    //     String container = "omnia";
    //     // Create a JSON object containing both the image path and text data
    //     Map<String, dynamic> data = {
    //       'image': fileName, // Use the file name as the image path
    //       'text': text,
    //     };

    //     // Convert the JSON object to a string
    //     String jsonData = jsonEncode(data);

    //     // Upload the combined content
    //     await storage.putBlob(
    //       '/$container/$fileName',
    //       bodyBytes: utf8.encode(jsonData), // Convert string to bytes
    //       contentType: 'application/json', // Set content type to JSON
    //       type: BlobType.blockBlob,
    //     );

    //     print("Image and text uploaded successfully.");

    //     print("done");
    //   } on AzureStorageException catch (ex) {
    //     print(ex.message);
    //   } catch (err) {
    //     print(err);
    //   }
  }

/*{
  "image": "example_image.jpg",
  "text": "This is the text associated with the image."
}
*/
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Image Upload to Azure'),
        ),
        body: Center(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 200,
                      width: 200,
                      padding: EdgeInsets.all(10),
                      child: Lottie.asset(
                        'assets/Lottie/face.json',
                        height: 150,
                      ),
                    ),
                    Container(
                      child: const Text(
                        "Image recognition",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    _image == null
                        ? Text('No image selected.')
                        : Image.file(
                            _image!,
                            height: 200,
                          ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.camera),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 167, 179)),
                        ),
                        child: const Text(
                          "Take Picture",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _pickImage(ImageSource.gallery),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 167, 179)),
                        ),
                        child: const Text(
                          "Choose from Gallery",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Conditionally show the text input field if an image is selected
                    if (_image != null)
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => uploadImageToAzure(context),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 255, 167, 179),
                            ),
                          ),
                          child: const Text(
                            "Upload Image",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

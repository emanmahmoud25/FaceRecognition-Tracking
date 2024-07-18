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

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  File? _video;
  final picker = ImagePicker();

  Future<void> _pickVideo() async {
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _video = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadVideoToAzure(BuildContext context) async {
    try {
      String fileName = basename(_video!.path);
      Uint8List content = await _video!.readAsBytes();
      var storage = AzureStorage.parse(
          'DefaultEndpointsProtocol=https;AccountName=dataset7;AccountKey=yQc8xFTR6LdfUSg6J19C0Z6DhzrgrS9rnjT6QkA+WPl5QNAGTtrFP84a7prOkXSQUziyXi1Q1VYq+ASt5vURfQ==;EndpointSuffix=core.windows.net');
      String container = "newcriminal";
      String contentType = lookupMimeType(fileName)!;
      await storage.putBlob('/$container/$fileName',
          bodyBytes: content,
          contentType: contentType,
          type: BlobType.blockBlob);
      Fluttertoast.showToast(
          msg: "Video uploaded successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } on AzureStorageException catch (ex) {
      Fluttertoast.showToast(
        msg: ex
            .message, // Assuming ex is an Exception object with a message field
        toastLength: Toast.LENGTH_LONG, // Duration of the toast message
        gravity:
            ToastGravity.BOTTOM, // Position of the toast message on the screen
        backgroundColor: Colors.red, // Background color of the toast message
        textColor: Colors.white, // Text color of the toast message
      );
    } catch (err) {
      Fluttertoast.showToast(
        msg: err.toString(), // Assuming err is an error object
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      ); // Fluttertoast.showToast(
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Upload to Azure Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 200,
              padding: EdgeInsets.all(10),
              child: Lottie.asset(
                'assets/Lottie/Animation - 1713428912571.json',
                height: 150,
              ),
            ),
            Container(
              child: const Text(
                "Upload Video to Server",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () => _pickVideo(),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 255, 167, 179)),
              ),
              child: Text(
                'Pick Video',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            if (_video != null)
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => uploadVideoToAzure(context),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 167, 179)),
                  ),
                  child: const Text(
                    "Upload Video ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

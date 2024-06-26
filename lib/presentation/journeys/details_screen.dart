import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

// aslo add shadow in the back of the image

class DetailsScreen extends StatelessWidget {
  final String imagePath;
  const DetailsScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: imagePath,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
        Positioned(
          top: 40.0,
          left: 10.0,
          right: 10.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.back,
                    color: Colors.white, size: 30.0),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
        // Positioned(
        //   bottom: 30.0,
        //   right: 20.0,
        //   child: Container(
        //     padding: const EdgeInsets.all(10.0),
        //     decoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.5),
        //       borderRadius: BorderRadius.circular(10.0),
        //     ),
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         const SizedBox(height: 10.0),
        //         InkWell(
        //           onTap: () async {
        //             saveImageToGallery(imagePath);
        //           },
        //           child: const Icon(CupertinoIcons.cloud_download,
        //               color: Colors.white, size: 25.0),
        //         ),
        //         const SizedBox(height: 20.0),
        //         InkWell(
        //           onTap: () {},
        //           child: const Icon(CupertinoIcons.share,
        //               color: Colors.white, size: 25.0),
        //         ),
        //         const SizedBox(height: 10.0),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// ask permission
void askPermission(bool permissionGranted) {
  if (!permissionGranted) {
    Fluttertoast.showToast(
        msg: "Please grant storage permission to save image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  // grant permission
}

Future<void> requestPermissions() async {
  // Request storage permission
  var storageStatus = await Permission.storage.request();
  if (storageStatus.isGranted) {
    print('Storage permission granted');
  } else {
    print('Storage permission denied');
    // Handle the case where permission is denied (optional)
  }
}

Future<void> saveImageToGallery(String assetPath) async {
  final ByteData imageData = await rootBundle.load(assetPath);
  final List<int> bytes = imageData.buffer.asUint8List();
  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
  await requestPermissions();
  if (result['isSuccess']) {
    // Image is saved successfully
    print('Image saved to gallery');
    Fluttertoast.showToast(
        msg: "Image saved to gallery",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
    // toast message
  } else {
    // Handle the error
    print('Error saving image');
    Fluttertoast.showToast(
        msg: "Error saving image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

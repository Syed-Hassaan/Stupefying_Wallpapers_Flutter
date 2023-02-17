import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:image_downloader/image_downloader.dart';

class FullScreenPicture extends StatelessWidget {
  String imgSrc;
  FullScreenPicture({super.key, required this.imgSrc});
  Future<void> downloadWallpaper(
      String wallpaperUrl, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Downloading..."),
      ),
    );

    // To save file in mobile device - method
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(wallpaperUrl);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Downloaded Sucessfuly"),
          action: SnackBarAction(
              label: "Open",
              onPressed: () {
                OpenFile.open(path);
              }),
        ),
      );
    } on PlatformException catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await downloadWallpaper(imgSrc, context);
        },
        child: Text(
          "Download Wallpaper",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.redAccent)),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.network(
          imgSrc,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

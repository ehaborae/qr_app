import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QRPage extends StatefulWidget {
  QRPage({
    Key? key,
    required this.qrData,
  }) : super(key: key);
  final String qrData;

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  ScreenshotController screenshotController = ScreenshotController();

  File? imageFile;

  bool showImage = false;

  Future<void> captureQR() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    final path = directory;

    screenshotController
        .captureAndSave(
      path,
      fileName: 'qr.png',
    )
        .then((value) async {
      await GallerySaver.saveImage(value!).then((success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('QR Code saved to gallery'),
          ),
        );
      });
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving QR Code'),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Congratulations!',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Screenshot(
              controller: screenshotController,
              child: Container(
                width: 200,
                height: 200,
                color: Colors.white,
                child: QrImage(
                  data: widget.qrData,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            if (showImage)
              Image.file(
                imageFile!,
                height: 200,
                width: 200,
              ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        'create new QR',
                        style: TextStyle(color: Colors.grey[200]),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () async {
                      await captureQR();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        'save QR',
                        style: TextStyle(color: Colors.grey[200]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

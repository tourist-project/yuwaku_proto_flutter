import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class TestCloudStoragePage extends StatefulWidget {
  @override
  _TestCloudStoragePageState createState() => _TestCloudStoragePageState();
}

class _TestCloudStoragePageState extends State<TestCloudStoragePage> {

  final storage = FirebaseStorage.instance;
  final _imagePath = 'assets/images/Asiyu(temp).png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset(_imagePath),
            TextButton(
              onPressed: () async {
                final File imageFile = await getImageFileFromAssets(_imagePath);
                final ref = storage.ref();
                ref.child("test").putFile(imageFile);
              },
              child: Text('click here'),
            )
          ],
        ),
      ),
    );
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);

    final file = File('${(await getApplicationDocumentsDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
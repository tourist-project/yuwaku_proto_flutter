import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';

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
              onPressed: () {
                final imageFile = File(_imagePath);
                _upload(imageFile);
              },
              child: Text('click here'),
            )
          ],
        ),
      ),
    );
  }
  Future _upload(File? file) async {
    final ref = storage.ref();
    await ref.child("test").putFile(file!);
  }
}
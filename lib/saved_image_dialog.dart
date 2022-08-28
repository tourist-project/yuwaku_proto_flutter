import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SavedImageDialog extends StatelessWidget {
  const SavedImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '写真の保存が完了しました',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15
        ),
      ),
      actions: [
        TextButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
      ],
    );
  }
}
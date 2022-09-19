import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yuwaku_proto/goal.dart';

class DocumentsDirectoryClient {
  static Future<String> get _folderLocationPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> _createSaveImageFolderPath() async {
    final localPath = await _folderLocationPath;
    return localPath;
  }

  String _spotPath(Goal goal) {
    switch (goal) {
      case Goal.himurogoya:
        return 'himurogoya';
      case Goal.yumejikan:
        return 'yumejikan';
      case Goal.soyu:
        return 'soyu';
      case Goal.ashiyu:
        return 'ashiyu';
      case Goal.yakushiji:
        return 'yakushiji';
      case Goal.midorinosato:
        return 'midorinosato';
    }
  }

  Future<String> getDocumentsDirectoryPath(Goal goal) async {
    final saveImageFolderPath = await _createSaveImageFolderPath();
    final spotDirectoryPath = _spotPath(goal);
    return '$saveImageFolderPath/$spotDirectoryPath';
  }

  Future<File> saveImage(Goal goal, String imagePath) async {
    final documentDirectoryPath = await getDocumentsDirectoryPath(goal);
    final saveImagePath = '$documentDirectoryPath';
    final savedImagePath = await File(saveImagePath).writeAsBytes(File(imagePath).readAsBytesSync());
    return savedImagePath;
  }
}

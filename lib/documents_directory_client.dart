import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:yuwaku_proto/goal.dart';

class DocumentsDirectoryClient {
  static Future<String> get _folderLocationPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _createSaveImageFolderData(String imagePath) async {
    final localPath = await _folderLocationPath;
    return File(localPath + imagePath);
  }

  String _spotPath(Goal goal) {
    switch (goal) {
      case Goal.himurogoya:
        return '/himurogoya.jpg';
      case Goal.yumejikan:
        return '/yumejikan.jpg';
      case Goal.soyu:
        return '/soyu.jpg';
      case Goal.ashiyu:
        return '/ashiyu.jpg';
      case Goal.yakushiji:
        return '/yakushiji.jpg';
    }
  }

  void saveImage(File image, Goal goal) async {
    final _documentsDirectoryPath = _spotPath(goal);
    File directoryData = await _createSaveImageFolderData(_documentsDirectoryPath);
    await directoryData.writeAsBytes(await image.readAsBytes());
  }

  Future<File> loadImage(Goal goal) async {
    final _documentsDirectoryPath = _spotPath(goal);
    File data = await _createSaveImageFolderData(_documentsDirectoryPath);
    return data;
  }
}

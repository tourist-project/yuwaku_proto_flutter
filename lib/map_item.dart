import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'database.dart';

/// 場所情報
class MapItem {
  final String name;/// 場所の名前
  final double latitude;/// 緯度
  final double longitude;/// 経度
  final ui.Offset position;/// 画像上の座標
  final String initialImagePath;/// イラストのパス

  double? distance; /// 距離
  ui.Rect photoRect;/// 画像の四角
  ui.Image? initialImage;

  final imageDb = ImageDBProvider.instance;/// 初期化時のイラスト
  ui.Image? photoImage;

  /// イニシャライズ
  MapItem(this.name, this.latitude, this.longitude, this.position, this.initialImagePath, this.photoRect);

  /// 初期画像のロード
  Future loadInitialImage() async {
    initialImage = await loadUiImage(initialImagePath);
    if (await imageDb.isExist(this.name)) {
      final rawStr = (await imageDb.querySearchRows(this.name))[0]['image']! as String;
      Uint8List raw = base64.decode(rawStr);
      ui.decodeImageFromList(raw, (ui.Image img) => {this.photoImage = img});
    }
  }

  /// 表示すべき画像を返す
  ui.Image? getDisplayImage() {
    if (photoImage == null) {
      return initialImage;
    }
    return photoImage;
  }

  /// image ウィジェットとして画像を返す
  Future<Image?> getDisplayImageToImageWidget() async {
    try {
      final img = this.getDisplayImage();
      if (img == null) return null;
      ByteData byteData = (await img.toByteData(format: ui.ImageByteFormat.png))!;
      final pngBytes = byteData.buffer.asUint8List();
      return Image.memory(pngBytes, fit: BoxFit.cover);
    } catch (e) {
      return null;
    }
  }

  /// 座標系をマップ画像上からデバイス上へ変換
  ui.Rect getPhotoRectForDeviceFit(double scale, double moveX) {
    return Rect.fromLTWH(photoRect.left * scale - moveX, photoRect.top * scale,
        photoRect.width * scale, photoRect.height * scale);
  }

  /// タップ判定をしてタップの場合はタップ処理をする
  bool didTappedImageTransition(double scale, double moveX, Offset tapLoc) {
    final tapX = tapLoc.dx;
    final tapY = tapLoc.dy;
    final rect = getPhotoRectForDeviceFit(scale, moveX);

    if (rect.left <= tapX && tapX <= rect.right &&
        rect.top <= tapY && tapY <= rect.bottom) {
      return true;
    }
    return false;
  }

  /// 距離を図る
  void setDistance(Position position) {
    this.distance = Geolocator.distanceBetween(position.latitude, position.longitude, this.latitude, this.longitude);
  }

  /// 近接判定
  bool isProximity(double range) {
    if (this.distance == null) {
      return false;
    } else {
      return this.distance! <= range;
    }
  }

  /// アセットのパスからui.Imageをロード
  static Future<ui.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}

class MapItemList extends StateNotifier<List<MapItem>> {
  MapItemList([List<MapItem>? initialTodos]) : super(initialTodos ?? []);

  void edit({required String name, required String path}) {
    state = [
      for (final spot in state)
        if (spot.name == name)
          MapItem(spot.name, spot.latitude, spot.longitude, spot.position, path, spot.photoRect)
        else
          spot,
    ];
  }
}
import 'package:flutter/cupertino.dart';
import 'package:listy_chef/core/presentation/foundation/image_asset.dart';

@immutable
class AppImages {
  const AppImages._();

  static ImageAsset load(String file) => ImageAsset('assets/images/$file');
  static ImageAsset loadPng(String filename) => load('$filename.png');
  static ImageAsset loadSvg(String filename) => load('$filename.svg');
  static ImageAsset loadGif(String filename) => load('$filename.gif');
}

import 'package:listy_chef/core/presentation/foundation/image_asset.dart';

abstract final class AppImages {
  static UnspecifiedImageAsset load(String file) =>
    UnspecifiedImageAsset(value: 'assets/images/$file');

  static PngImageAsset loadPng(String filename) =>
    PngImageAsset.fromUnspecified(load('$filename.png'));

  static SvgImageAsset loadSvg(String filename) =>
    SvgImageAsset.fromUnspecified(load('$filename.svg'));

  static GifImageAsset loadGif(String filename) =>
    GifImageAsset.fromUnspecified(load('$filename.gif'));
}

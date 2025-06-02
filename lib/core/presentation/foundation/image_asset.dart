sealed class ImageAsset {
  final String value;
  ImageAsset({required this.value});
}

final class UnspecifiedImageAsset extends ImageAsset {
  UnspecifiedImageAsset({required super.value});
}

final class PngImageAsset extends ImageAsset {
  PngImageAsset({required super.value});

  factory PngImageAsset.fromUnspecified(UnspecifiedImageAsset asset) =>
    PngImageAsset(value: asset.value);
}

final class SvgImageAsset extends ImageAsset {
  SvgImageAsset({required super.value});

  factory SvgImageAsset.fromUnspecified(UnspecifiedImageAsset asset) =>
    SvgImageAsset(value: asset.value);
}

final class GifImageAsset extends ImageAsset {
  GifImageAsset({required super.value});

  factory GifImageAsset.fromUnspecified(UnspecifiedImageAsset asset) =>
    GifImageAsset(value: asset.value);
}

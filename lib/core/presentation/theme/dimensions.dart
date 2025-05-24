import 'package:flutter/cupertino.dart';

@immutable
final class AppDimensions {
  final AppPadding padding;
  final AppRadius radius;
  final AppSize size;
  final AppOffsets offset;

  const AppDimensions({
    this.padding = const AppPadding(),
    this.radius = const AppRadius(),
    this.size = const AppSize(),
    this.offset = const AppOffsets(),
  });
}

@immutable
final class AppPadding {
  final double zero;
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;
  final double big;
  final double extraBig;
  final double large;
  final double extraLarge;
  final double enormous;
  final double extraEnormous;

  const AppPadding({
    this.zero = 0.0,
    this.minimum = 2.0,
    this.extraSmall = 4.0,
    this.small = 8.0,
    this.medium = 12.0,
    this.extraMedium = 16.0,
    this.big = 20.0,
    this.extraBig = 24.0,
    this.large = 32.0,
    this.extraLarge = 48.0,
    this.enormous = 64.0,
    this.extraEnormous = 128.0
  });
}

@immutable
final class AppRadius {
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;

  const AppRadius({
    this.minimum = 4.0,
    this.extraSmall = 8.0,
    this.small = 16.0,
    this.medium = 20.0,
    this.extraMedium = 24.0,
  });
}

@immutable
final class AppSize {
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;
  final double big;
  final double extraBig;
  final double large;
  final double extraLarge;
  final double enormous;
  final double extraEnormous;
  final AppLineSize line;

  const AppSize({
    this.minimum = 12.0,
    this.extraSmall = 16.0,
    this.small = 24.0,
    this.medium = 32.0,
    this.extraMedium = 48.0,
    this.big = 64.0,
    this.extraBig = 72.0,
    this.large = 128.0,
    this.extraLarge = 256.0,
    this.enormous = 312.0,
    this.extraEnormous = 512.0,
    this.line = const AppLineSize(),
  });
}

@immutable
final class AppLineSize {
  final double minimum;
  final double extraSmall;
  final double small;
  final double medium;
  final double extraMedium;
  final double big;
  final double extraBig;
  final double large;
  final double extraLarge;
  final double enormous;

  const AppLineSize({
    this.minimum = 0.5,
    this.extraSmall = 1,
    this.small = 2,
    this.medium = 4,
    this.extraMedium = 8,
    this.big = 12,
    this.extraBig = 16,
    this.large = 20,
    this.extraLarge = 24,
    this.enormous = 32,
  });
}

@immutable
final class AppOffsets {
  final Offset shadow;

  const AppOffsets({
    this.shadow = const Offset(4, 4),
  });
}

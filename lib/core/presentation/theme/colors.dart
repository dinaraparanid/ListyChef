import 'package:flutter/material.dart';

const _MintCream = Color(0xFFF4FFFD);
const _MintCream75 = Color(0xBFF4FFFD);
const _Gray = Color(0xFF817F82);
const _Crayola = Color(0xFF2667FF);
const _SlateBlue = Color(0xFF6C5ED9);
const _Independence = Color(0xFF465362);
const _InterdimensionalBlue = Color(0xFF3B28CC);
const _InterdimensionalBlue75 = Color(0xBF3B28CC);
const _InterdimensionalBlue50 = Color(0x803B28CC);
const _PaleCornflowerBlue = Color(0xFFADD7F6);
const _ChineseBlack = Color(0xFF0A1310);
const _PersianRed = Color(0xFFD73232);

@immutable
final class AppColors {
  final Color primary;
  final Color error;
  final AppBackgroundColors background;
  final AppButtonColors button;
  final AppTextColors text;
  final AppIconColors icon;
  final AppNavigationBarColors navigationBar;

  const AppColors({
    this.primary = _InterdimensionalBlue,
    this.error = _PersianRed,
    this.background = const AppBackgroundColors(),
    this.button = const AppButtonColors(),
    this.text = const AppTextColors(),
    this.icon = const AppIconColors(),
    this.navigationBar = const AppNavigationBarColors(),
  });
}

@immutable
final class AppBackgroundColors {
  final Color primary;
  final Color secondary;

  const AppBackgroundColors({
    this.primary = _MintCream,
    this.secondary = _Gray,
  });
}

@immutable
final class AppButtonColors {
  final Color primary;
  final Color disabled;
  final Color textEnabled;
  final Color textDisabled;
  final Color ripple;

  const AppButtonColors({
    this.primary = _InterdimensionalBlue,
    this.disabled = _InterdimensionalBlue50,
    this.textEnabled = _InterdimensionalBlue,
    this.textDisabled = _Gray,
    this.ripple = _InterdimensionalBlue75,
  });
}

@immutable
final class AppTextColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color disabled;
  final Color focused;
  final Color unfocused;

  const AppTextColors({
    this.primary = _Independence,
    this.secondary = _MintCream,
    this.background = _MintCream,
    this.disabled = _MintCream75,
    this.focused = _Crayola,
    this.unfocused = _SlateBlue,
  });
}

@immutable
final class AppIconColors {
  final Color primary;

  const AppIconColors({
    this.primary = _ChineseBlack,
  });
}

@immutable
final class AppNavigationBarColors {
  final Color background;
  final Color selected;
  final Color unselected;

  const AppNavigationBarColors({
    this.background = _InterdimensionalBlue,
    this.selected = _MintCream,
    this.unselected = _PaleCornflowerBlue,
  });
}

import 'package:flutter/material.dart';

const _MintCream = Color(0xFFF4FFFD);
const _MintCream75 = Color(0xBFF4FFFD);
const _Gray = Color(0xFF817F82);
const _Crayola = Color(0xFF2667FF);
const _Crayola75 = Color(0xBF2667FF);
const _SlateBlue = Color(0xFF6C5ED9);
const _Independence = Color(0xFF465362);
const _Independence75 = Color(0xBF465362);
const _InterdimensionalBlue = Color(0xFF3B28CC);
const _InterdimensionalBlue75 = Color(0xBF3B28CC);
const _InterdimensionalBlue50 = Color(0x803B28CC);
const _PaleCornflowerBlue = Color(0xFFADD7F6);
const _ChineseBlack = Color(0xFF0A1310);
const _PersianRed = Color(0xFFD73232);
const _Mint = Color(0xFF09BC8A);
const _Jacarta = Color(0xFF3F4060);
const _Arsenic = Color(0xFF3D3A4B);
const _Arsenic50 = Color(0x803D3A4B);
const _WarmBlack = Color(0xFF004346);
const _PaleRobinEggBlue50 = Color(0x809AD1D4);

@immutable
final class AppColors {
  final Color primary;
  final Color error;
  final AppBackgroundColors background;
  final AppButtonColors button;
  final AppTextColors text;
  final AppSearchFieldColors searchField;
  final AppIconColors icon;
  final AppNavigationBarColors navigationBar;
  final AppSnackBarColors snackBar;
  final AppCheckboxColors checkbox;
  final AppUniqueComponentsColors unique;

  const AppColors({
    this.primary = _InterdimensionalBlue,
    this.error = _PersianRed,
    this.background = const AppBackgroundColors(),
    this.button = const AppButtonColors(),
    this.text = const AppTextColors(),
    this.searchField = const AppSearchFieldColors(),
    this.icon = const AppIconColors(),
    this.navigationBar = const AppNavigationBarColors(),
    this.snackBar = const AppSnackBarColors(),
    this.checkbox = const AppCheckboxColors(),
    this.unique = const AppUniqueComponentsColors(),
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
final class AppSearchFieldColors {
  final Color background;
  final Color border;
  final Color text;
  final Color placeholder;

  const AppSearchFieldColors({
    this.background = Colors.white,
    this.border = _Jacarta,
    this.text = _Arsenic,
    this.placeholder = _Arsenic50,
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
  final Color backgroundCollapsed;
  final Color selected;
  final Color unselected;

  const AppNavigationBarColors({
    this.background = _InterdimensionalBlue,
    this.backgroundCollapsed = _Independence,
    this.selected = _MintCream,
    this.unselected = _PaleCornflowerBlue,
  });
}

@immutable
final class AppSnackBarColors {
  final Color error;
  final Color success;
  final Color info;
  final Color content;

  const AppSnackBarColors({
    this.error = _PersianRed,
    this.success = _Mint,
    this.info = _InterdimensionalBlue,
    this.content = _MintCream,
  });
}

@immutable
final class AppCheckboxColors {
  final Color inactive;
  final Color active;
  final Color check;

  const AppCheckboxColors({
    this.inactive = _MintCream,
    this.active = _WarmBlack,
    this.check = _MintCream,
  });
}

@immutable
final class AppUniqueComponentsColors {
  final Color todoProductBackground;
  final Color addedProductBackground;
  final Color todoProductText;
  final Color addedProductText;

  const AppUniqueComponentsColors({
    this.todoProductBackground = _Crayola75,
    this.addedProductBackground = _PaleRobinEggBlue50,
    this.todoProductText = _MintCream,
    this.addedProductText = _Independence75,
  });
}

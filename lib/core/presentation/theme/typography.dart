import 'package:flutter/cupertino.dart';

@immutable
class AppTypography {
  final AppHTypo h;
  final TextStyle body;
  final TextStyle regular;
  final TextStyle caption;
  final TextStyle captionSm;

  const AppTypography({
    this.h = const AppHTypo(),
    this.body = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
    this.regular = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.4,
      decoration: TextDecoration.none,
    ),
    this.caption = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.4,
      decoration: TextDecoration.none,
    ),
    this.captionSm = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
  });
}

@immutable
class AppHTypo {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;

  const AppHTypo({
    this.h1 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 32,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
    this.h2 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 24,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
    this.h3 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 20,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
    this.h4 = const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontSize: 18,
      letterSpacing: 0,
      decoration: TextDecoration.none,
    ),
  });
}

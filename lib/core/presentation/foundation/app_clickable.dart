import 'package:flutter/material.dart';

final class AppClickable extends StatelessWidget {
  final void Function() onClick;
  final ShapeBorder? border;
  final Color? rippleColor;
  final Widget child;

  const AppClickable({
    super.key,
    required this.onClick,
    this.border,
    this.rippleColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onClick,
      customBorder: border,
      splashColor: rippleColor,
      child: Ink(child: IgnorePointer(child: child)),
    ),
  );
}

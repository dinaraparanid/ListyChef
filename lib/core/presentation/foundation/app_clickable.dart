import 'package:flutter/material.dart';

final class AppClickable extends StatelessWidget {
  final void Function()? onClick;
  final void Function()? onLongClick;
  final ShapeBorder? border;
  final Color? rippleColor;
  final Widget child;

  const AppClickable({
    super.key,
    this.onClick,
    this.onLongClick,
    this.border,
    this.rippleColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.transparent,
    child: InkWell(
      onTap: onClick,
      onLongPress: onLongClick,
      customBorder: border,
      focusColor: rippleColor,
      hoverColor: rippleColor,
      highlightColor: rippleColor,
      splashColor: rippleColor,
      child: Ink(child: IgnorePointer(child: child)),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

final class AppTextButton extends StatelessWidget {
  static const _animationDuration = Duration(milliseconds: 300);

  final String text;
  final bool isEnabled;
  final Color? enabledColor;
  final Color? disabledColor;
  final void Function() onClick;

  const AppTextButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isEnabled = true,
    this.enabledColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return AnimatedContainer(
      duration: _animationDuration,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(theme.dimensions.radius.small),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? onClick : null,
          borderRadius: BorderRadius.all(
            Radius.circular(theme.dimensions.radius.small),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              vertical: theme.dimensions.padding.small,
              horizontal: theme.dimensions.padding.large,
            ),
            child: Content(context: context),
          ),
        ),
      ),
    );
  }

  Widget Content({required BuildContext context}) {
    final theme = context.appTheme;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        style: theme.typography.h.h3.copyWith(
          fontWeight: FontWeight.w700,
          color: isEnabled
            ? (enabledColor ?? theme.colors.button.textEnabled)
            : (disabledColor ?? theme.colors.button.textDisabled),
        ),
      ),
    );
  }
}

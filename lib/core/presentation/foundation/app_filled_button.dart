import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_progress_indicator.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';

final class AppFilledButton extends StatelessWidget {
  static const _animationDuration = Duration(milliseconds: 300);

  final String text;
  final bool isEnabled;
  final bool isLoading;
  final Color? enabledColor;
  final Color? disabledColor;
  final Color? enabledTextColor;
  final Color? disabledTextColor;
  final void Function() onClick;

  const AppFilledButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isEnabled = true,
    this.isLoading = false,
    this.enabledColor,
    this.disabledColor,
    this.enabledTextColor,
    this.disabledTextColor,
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
        color: isEnabled && isLoading.not
          ? enabledColor ?? theme.colors.button.primary
          : disabledColor ?? theme.colors.button.disabled,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled && isLoading.not ? onClick : null,
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

    return switch (isLoading) {
      true => AppProgressIndicator(size: theme.dimensions.size.small),

      false => FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: theme.typography.h.h3.copyWith(
            color: isEnabled
              ? theme.colors.text.secondary
              : theme.colors.text.disabled,
          ),
        ),
      ),
    };
  }
}
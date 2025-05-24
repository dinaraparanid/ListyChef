import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/app_progress_indicator.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/utils/ext/bool_ext.dart';

final class AppButton extends StatelessWidget {
  final String text;
  final bool isEnabled;
  final bool isLoading;
  final Color? enabledColor;
  final Color? disabledColor;
  final void Function() onClick;

  const AppButton({
    super.key,
    required this.text,
    required this.onClick,
    this.isEnabled = true,
    this.isLoading = false,
    this.enabledColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return FilledButton(
      onPressed: isEnabled && isLoading.not ? onClick : null,
      style: FilledButton.styleFrom(
        backgroundColor: enabledColor ?? theme.colors.button.primary,
        foregroundColor: theme.colors.text.primary,
        disabledBackgroundColor: disabledColor ?? theme.colors.button.disabled,
        disabledForegroundColor: theme.colors.text.disabled,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.dimensions.radius.small),
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: theme.dimensions.padding.small,
          horizontal: theme.dimensions.padding.large,
        ),
        child: Content(context: context),
      ),
    );
  }

  Widget Content({required BuildContext context}) {
    final theme = context.appTheme;

    return switch (isLoading) {
      true => AppProgressIndicator(size: theme.dimensions.size.small),

      false => FittedBox(
        fit: BoxFit.fitWidth,
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
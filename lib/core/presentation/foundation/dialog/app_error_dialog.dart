import 'package:fluent_ui/fluent_ui.dart' hide Colors, showDialog;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:listy_chef/core/presentation/foundation/app_filled_button.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:listy_chef/core/presentation/theme/strings.dart';
import 'package:listy_chef/core/utils/ext/general.dart';

Future<void> showAppErrorDialog({
  required BuildContext context,
  String? title,
  required String description,
  String? positiveButton,
  void Function(BuildContext)? onPositiveClicked,
  String? negativeButton,
  void Function(BuildContext)? onNegativeClicked,
}) => platformCall(
  android: _showMaterialErrorDialog,
  iOS: _showCupertinoErrorDialog,
  macOS: _showCupertinoErrorDialog,
  linux: _showMaterialErrorDialog,
  windows: _showFluentErrorDialog,
)(
  context: context,
  title: title,
  description: description,
  positiveButton: positiveButton,
  onPositiveClicked: onPositiveClicked,
  negativeButton: negativeButton,
  onNegativeClicked: onNegativeClicked,
);

Future<void> _showMaterialErrorDialog({
  required BuildContext context,
  String? title,
  required String description,
  String? positiveButton,
  void Function(BuildContext)? onPositiveClicked,
  String? negativeButton,
  void Function(BuildContext)? onNegativeClicked,
}) => showDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: false,
  builder: (context) {
    final theme = context.appTheme;

    return AlertDialog(
      backgroundColor: theme.colors.background.primary,
      surfaceTintColor: Colors.transparent,
      titlePadding: EdgeInsets.symmetric(
        vertical: theme.dimensions.padding.extraMedium,
        horizontal: theme.dimensions.padding.extraMedium,
      ),
      title: title?.let((txt) => Text(
        txt,
        style: theme.typography.h.h3.copyWith(
          color: theme.colors.text.primary,
          fontWeight: FontWeight.w700,
        ),
      )),
      content: Text(
        description,
        style: theme.typography.body.copyWith(
          color: theme.colors.text.primary,
        ),
      ),
      actions: [
        if (negativeButton != null) TextButton(
          onPressed: () {
            onNegativeClicked?.call(context);
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: theme.colors.primary,
          ),
          child: Text(
            negativeButton,
            style: theme.typography.regular.copyWith(
              color: theme.colors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        TextButton(
          onPressed: () {
            onPositiveClicked?.call(context);
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(
            foregroundColor: theme.colors.primary,
          ),
          child: Text(
            positiveButton ?? context.strings.ok,
            style: theme.typography.regular.copyWith(
              color: theme.colors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  },
);

Future<void> _showCupertinoErrorDialog({
  required BuildContext context,
  String? title,
  required String description,
  String? positiveButton,
  void Function(BuildContext)? onPositiveClicked,
  String? negativeButton,
  void Function(BuildContext)? onNegativeClicked,
}) => showCupertinoDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: false,
  builder: (context) => CupertinoTheme(
    data: CupertinoThemeData(brightness: Brightness.light),
    child: CupertinoAlertDialog(
      title: title?.let((txt) => Text(txt)),
      content: Text(description),
      actions: [
        if (negativeButton != null) CupertinoDialogAction(
          onPressed: () {
            onNegativeClicked?.call(context);
            Navigator.of(context).pop();
          },
          child: Text(negativeButton),
        ),

        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            onPositiveClicked?.call(context);
            Navigator.of(context).pop();
          },
          child: Text(positiveButton ?? context.strings.ok),
        ),
      ],
    ),
  ),
);

Future<void> _showFluentErrorDialog({
  required BuildContext context,
  String? title,
  required String description,
  String? positiveButton,
  void Function(BuildContext)? onPositiveClicked,
  String? negativeButton,
  void Function(BuildContext)? onNegativeClicked,
}) => showDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: false,
  builder: (context) {
    final theme = context.appTheme;

    return ContentDialog(
      style: ContentDialogThemeData(
        actionsDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      title: title?.let((txt) => Text(
        txt,
        style: theme.typography.h.h3.copyWith(
          color: theme.colors.text.primary,
          fontWeight: FontWeight.w700,
        ),
      )),
      content: Text(
        description,
        style: theme.typography.body.copyWith(
          color: theme.colors.text.primary,
        ),
      ),
      actions: [
        if (negativeButton != null) AppFilledButton(
          text: negativeButton,
          onClick: () {
            onNegativeClicked?.call(context);
            Navigator.of(context).pop();
          },
        ),

        AppFilledButton(
          text: positiveButton ?? context.strings.ok,
          onClick: () {
            onPositiveClicked?.call(context);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  },
);

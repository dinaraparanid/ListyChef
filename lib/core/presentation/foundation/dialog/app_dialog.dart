import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

Future<void> showAppDialog({
  required BuildContext context,
  required Widget Function(BuildContext) contentBuilder,
}) => platformCall(
  android: _showMaterialDialog,
  iOS: _showCupertinoDialog,
  macOS: _showCupertinoDialog,
  linux: _showMaterialDialog,
  windows: _showFluentDialog,
  web: _showMaterialDialog,
)(
  context: context,
  contentBuilder: contentBuilder,
);

Future<void> _showMaterialDialog({
  required BuildContext context,
  required Widget Function(BuildContext) contentBuilder,
}) => showDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: true,
  builder: (context) {
    final theme = context.appTheme;

    return AlertDialog(
      backgroundColor: theme.colors.navigationBar.background,
      surfaceTintColor: Colors.transparent,
      content: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 250),
        child: contentBuilder(context),
      ),
    );
  },
);

Future<void> _showCupertinoDialog({
  required BuildContext context,
  required Widget Function(BuildContext) contentBuilder,
}) => showCupertinoDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: true,
  builder: (context) => CupertinoTheme(
    data: CupertinoThemeData(brightness: Brightness.dark),
    child: CupertinoAlertDialog(
      content: contentBuilder(context),
    ),
  ),
);

Future<void> _showFluentDialog({
  required BuildContext context,
  required Widget Function(BuildContext) contentBuilder,
}) => showDialog(
  context: context,
  barrierDismissible: true,
  useRootNavigator: true,
  builder: (context) {
    final theme = context.appTheme;

    return win.ContentDialog(
      style: win.ContentDialogThemeData(
        decoration: BoxDecoration(
          color: theme.colors.navigationBar.background,
          borderRadius: BorderRadius.all(
            Radius.circular(theme.dimensions.radius.small),
          ),
        ),
        actionsDecoration: BoxDecoration(
          color: Colors.transparent,
        ),
      ),
      content: contentBuilder(context),
    );
  },
);

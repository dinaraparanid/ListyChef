import 'dart:async';
import 'dart:ui';
import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:yaru/widgets.dart';

enum AppSnackBarMode { error, success, info }

const _snackBarDuration = Duration(seconds: 3);

Future<void> showAppSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required AppSnackBarMode mode,
}) => platformCall(
  android: _showMaterialSnackBar,
  iOS: _showCupertinoSnackBar,
  macOS: _showCupertinoSnackBar,
  linux: _showYaruSnackBar,
  windows: _showFluentSnackBar,
)(
  context: context,
  title: title,
  message: message,
  mode: mode,
);

Color _snackBarColor({
  required BuildContext context,
  required AppSnackBarMode mode,
}) => switch (mode) {
  AppSnackBarMode.error => context.appTheme.colors.snackBar.error,
  AppSnackBarMode.success => context.appTheme.colors.snackBar.success,
  AppSnackBarMode.info => context.appTheme.colors.snackBar.info,
};

Future<void> _showMaterialSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required AppSnackBarMode mode,
}) async {
  final theme = context.appTheme;

  await ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: _snackBarColor(context: context, mode: mode),
      closeIconColor: theme.colors.snackBar.content,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      duration: _snackBarDuration,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(theme.dimensions.radius.medium),
        ),
      ),
      margin: EdgeInsets.only(
        left: theme.dimensions.padding.extraMedium,
        right: theme.dimensions.padding.extraMedium,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.typography.h.h4.copyWith(
              color: theme.colors.snackBar.content,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: theme.dimensions.padding.small),

          Text(
            message,
            style: theme.typography.regular.copyWith(
              color: theme.colors.snackBar.content,
            ),
          ),
        ],
      ),
    ),
  ).closed;
}

Future<void> _showCupertinoSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required AppSnackBarMode mode,
}) {
  final theme = context.appTheme;

  final overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: theme.dimensions.padding.small,
      left: theme.dimensions.padding.small,
      right: theme.dimensions.padding.small,
      child: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            context.appTheme.dimensions.radius.medium,
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: _snackBarColor(context: context, mode: mode)
                  .withValues(alpha: 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(theme.dimensions.padding.small),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: theme.typography.h.h4.copyWith(
                        color: theme.colors.text.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: theme.dimensions.padding.small),

                    Text(
                      message,
                      style: theme.typography.regular.copyWith(
                        color: theme.colors.text.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  Overlay.of(Navigator.of(context).context).insert(overlayEntry);
  return Future.delayed(_snackBarDuration, overlayEntry.remove);
}

Future<void> _showYaruSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required AppSnackBarMode mode,
}) async {
  final theme = context.appTheme;

  await ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: _snackBarColor(context: context, mode: mode),
      closeIconColor: theme.colors.snackBar.content,
      showCloseIcon: true,
      elevation: 0,
      content: YaruInfoBox(
        yaruInfoType: YaruInfoType.danger,
        color: theme.colors.background.primary,
        title: Text(
          title,
          style: theme.typography.body.copyWith(
            color: theme.colors.snackBar.content,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: Text(
          message,
          style: theme.typography.regular.copyWith(
            color: theme.colors.snackBar.content,
          ),
        ),
      ),
    ),
  ).closed;
}

Future<void> _showFluentSnackBar({
  required BuildContext context,
  required String title,
  required String message,
  required AppSnackBarMode mode,
}) {
  final theme = context.appTheme;

  return win.displayInfoBar(
    context,
    duration: _snackBarDuration,
    builder: (context, close) => win.InfoBar(
      style: win.InfoBarThemeData(
        icon: (_) => switch (mode) {
          AppSnackBarMode.error => win.FluentIcons.error,
          AppSnackBarMode.success => win.FluentIcons.check_mark,
          AppSnackBarMode.info => win.FluentIcons.info,
        },
        iconColor: (_) => theme.colors.snackBar.content,
        decoration: (_) => BoxDecoration(
          color: _snackBarColor(context: context, mode: mode),
        ),
      ),
      title: Text(
        title,
        style: theme.typography.body.copyWith(
          color: theme.colors.snackBar.content,
          fontWeight: FontWeight.w700,
        ),
      ),
      content: Text(
        message,
        style: theme.typography.regular.copyWith(
          color: theme.colors.snackBar.content,
        ),
      ),
      action: IconButton(
        icon: Icon(
          win.FluentIcons.clear,
          color: theme.colors.snackBar.content,
        ),
        onPressed: close,
      ),
    ),
  );
}

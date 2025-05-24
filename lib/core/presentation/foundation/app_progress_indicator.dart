import 'package:fluent_ui/fluent_ui.dart' as win;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';
import 'package:yaru/widgets.dart';

final class AppProgressIndicator extends StatelessWidget {
  final double? size;
  const AppProgressIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;
    final appliedSize = size ?? theme.dimensions.size.medium;

    return Wrap(children: [
      SizedBox(
        width: appliedSize,
        height: appliedSize,
        child: FittedBox(
          child: platformCall(
            android: MaterialIndicator,
            iOS: CupertinoIndicator,
            macOS: CupertinoIndicator,
            linux: YaruIndicator,
            windows: FluentIndicator,
          )(context: context),
        ),
      )
    ]);
  }

  Widget CupertinoIndicator({required BuildContext context}) =>
    CupertinoActivityIndicator(color: context.appTheme.colors.primary);

  Widget MaterialIndicator({required BuildContext context}) =>
    CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      valueColor: AlwaysStoppedAnimation(context.appTheme.colors.primary),
    );

  Widget YaruIndicator({required BuildContext context}) =>
    YaruCircularProgressIndicator(
      trackColor: context.appTheme.colors.primary,
    );

  Widget FluentIndicator({required BuildContext context}) =>
    win.FluentTheme(
      data: win.FluentThemeData(),
      child: win.ProgressRing(
        activeColor: context.appTheme.colors.primary,
        backgroundColor: context.appTheme.colors.background.primary,
      ),
    );
}

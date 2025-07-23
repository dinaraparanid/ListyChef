import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/presentation/theme/app_theme_provider.dart';

Future<void> showAppBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) => platformCall(
  android: _showMaterialBottomSheet,
  iOS: _showCupertinoBottomSheet,

  // TODO dialog for desktop
  macOS: _showCupertinoBottomSheet,
  linux: _showMaterialBottomSheet,
  windows: _showMaterialBottomSheet,
)(context: context, builder: builder);

Future<void> _showMaterialBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) => showModalBottomSheet(
  context: context,
  backgroundColor: context.appTheme.colors.background.modal,
  useRootNavigator: true,
  builder: (context) => SafeArea(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: context.appTheme.dimensions.padding.extraBig),
        builder(context),
      ],
    ),
  ),
);

Future<void> _showCupertinoBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
}) => showCupertinoModalPopup(
  context: context,
  useRootNavigator: true,
  builder: (context) => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: context.appTheme.colors.background.modal50,
        ),
        child: SafeArea(child: builder(context)),
      ),
    ),
  ),
);

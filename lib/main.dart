import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listy_chef/app.dart';
import 'package:listy_chef/core/data/firebase/init_firebase.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/di/app_module.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();

  await _configurePlatformSetup();
  await initFirebase();
  di.registerAppModule();
  runApp(App());
}

FutureOr<void> _configurePlatformSetup() => platformCall(
  android: () => doNothingFuture,
  iOS: () => doNothingFuture,
  macOS: _configureMacosWindowUtils,
  linux: () => _configureDesktopSetup,
  windows: () => _configureDesktopSetup,
)();

Future<void> _configureMacosWindowUtils() async {
  await _configureDesktopSetup();
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

Future<void> _configureDesktopSetup() async {
  await windowManager.ensureInitialized();

  final windowOptions = WindowOptions(
    size: Size(800, 600),
    minimumSize: Size(400, 300),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}

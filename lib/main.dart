import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listy_chef/app.dart';
import 'package:listy_chef/core/data/firebase/init_firebase.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/presentation/foundation/platform_call.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';
import 'package:listy_chef/di/app_module.dart';
import 'package:macos_ui/macos_ui.dart';

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
  linux: () => doNothingFuture,
  windows: () => doNothingFuture,
)();

Future<void> _configureMacosWindowUtils() async {
  const config = MacosWindowUtilsConfig();
  await config.apply();
}

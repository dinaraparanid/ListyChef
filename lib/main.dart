import 'package:flutter/material.dart';
import 'package:listy_chef/app.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/di/app_module.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.registerAppModule();
  runApp(App());
}

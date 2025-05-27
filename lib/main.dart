import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listy_chef/app.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/di/app_module.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  di.registerAppModule();
  runApp(App());
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:listy_chef/app.dart';
import 'package:listy_chef/core/data/firebase/init_firebase.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/di/app_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();

  await initFirebase();
  di.registerAppModule();
  runApp(App());
}

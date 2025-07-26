import 'package:firebase_core/firebase_core.dart';
import 'package:listy_chef/core/domain/logger/app_logger.dart';
import 'package:listy_chef/firebase_options.dart';

Future<void> initFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    AppLogger.value.e('Failed to init Firebase', error: e);
  }
}

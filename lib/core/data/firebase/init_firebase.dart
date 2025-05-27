import 'package:firebase_core/firebase_core.dart';
import 'package:listy_chef/firebase_options.dart';

Future<void> initFirebase() async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
}

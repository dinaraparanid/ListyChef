import 'package:listy_chef/core/data/firebase/firebase_config.dart';
import 'package:listy_chef/core/utils/functions/do_nothing.dart';

extension FirestoreOperationTimeout on Future<void> {
  Future<void> firestoreTimeout() => timeout(
    FirebaseConfig.firestoreOperationTimeout,
    onTimeout: doNothing,
  );
}

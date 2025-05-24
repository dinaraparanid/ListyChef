import 'package:flutter_test/flutter_test.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/di/app_module.dart';

void main() => test('Check dependency graph', () =>
    di.registerAppModule().forEach((type) => expect(canRetrieve(type), true))
);

bool canRetrieve(Type type) {
  try {
    di.get(type: type);
    return true;
  } catch (e) {
    // ignore: avoid_print
    print('Failed to get type $type: $e');
    return false;
  }
}

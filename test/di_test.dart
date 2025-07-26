import 'package:flutter_test/flutter_test.dart';
import 'package:listy_chef/core/di/di.dart';
import 'package:listy_chef/core/di/provide.dart';
import 'package:listy_chef/di/app_module.dart';

void main() => test('Check dependency graph', () =>
  di.registerAppModule().forEach((diEntity) => expect(canRetrieve(diEntity), true))
);

bool canRetrieve(DiEntity entity) {
  try {
    di(type: entity.type, instanceName: entity.qualifier);
    return true;
  } catch (e) {
    // ignore: avoid_print
    print('Failed to get $entity: $e');
    return false;
  }
}

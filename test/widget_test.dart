import 'package:flutter_test/flutter_test.dart';
import 'package:listy_chef/app.dart';

void main() {
  testWidgets('todo', (WidgetTester tester) async {
    await tester.pumpWidget(App());
  });
}

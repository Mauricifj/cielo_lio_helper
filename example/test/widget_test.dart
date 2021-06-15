import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cielo_lio_helper_example/main.dart';

void main() {
  testWidgets('Verify EC', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data.startsWith('EC:'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Verify Logic Number', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data.startsWith('LOGIC NUMBER:'),
      ),
      findsOneWidget,
    );
  });

  testWidgets('Verify Battery Level', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    expect(
      find.byWidgetPredicate(
        (Widget widget) => widget is Text && widget.data.startsWith('BATTERY LEVEL:'),
      ),
      findsOneWidget,
    );
  });
}

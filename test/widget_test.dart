import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:atomik_spor/main.dart';

void main() {
  testWidgets('opens habit tracker when button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final buttonFinder = find.byKey(const Key('showCalendarButton'));
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pumpAndSettle();

    expect(find.text('Habit Calendar'), findsOneWidget);
  });
}

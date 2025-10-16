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
    expect(find.textContaining('Daily Habits'), findsOneWidget);
    expect(find.text('0 of 3 habits completed'), findsOneWidget);

    final stretchHabitFinder =
        find.byKey(const Key('habitCheckbox_morningStretch'));
    expect(stretchHabitFinder, findsOneWidget);

    await tester.tap(stretchHabitFinder);
    await tester.pumpAndSettle();

    expect(find.text('1 of 3 habits completed'), findsOneWidget);
  });
}

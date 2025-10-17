import 'package:atomik_spor/main.dart';
import 'package:atomik_spor/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('initial route loads the welcome screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.byType(WelcomeScreen), findsOneWidget);
  });

  testWidgets('in-app navigation reaches /giris1', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final navigatorState = tester.state<NavigatorState>(find.byType(Navigator));
    navigatorState.pushNamed('/giris1');
    await tester.pumpAndSettle();

    expect(find.byType(WelcomeScreen), findsWidgets);
  });
}

// Smoke test for the app shell.
//
// Verifies the app boots, shows the branded splash, and that the primary
// CTA navigates to the home screen.

import 'package:flutter_riverpod_template/src/home/home_screen.dart';
import 'package:flutter_riverpod_template/src/my_app/my_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('app boots onto the splash screen', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(); // Kick off splash animation.

    expect(find.text('ShopVerse'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
  });

  testWidgets('Get Started navigates to the home screen', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    expect(find.text('Home Screen'), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
  });
}

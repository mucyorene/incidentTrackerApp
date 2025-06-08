import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:incident_tracker_app/views/authentication/sign_in_screen.dart';
import 'test_setup/test_foundation.dart' show testSetup;

void main() {
  late Widget root;

  setUp(() async {
    root = await testSetup(
      testLocale: Locale('en', 'US'),
      w: const SignInScreen(),
    );
  });

  testWidgets("Login screen Test English Translations", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pump();
      expect(find.text("Login to your account."), findsOneWidget);
    });
  });

  testWidgets("Login screen widget tree testing", (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(root);
      await tester.idle();
      await tester.pump();
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

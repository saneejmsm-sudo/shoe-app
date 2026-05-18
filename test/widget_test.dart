// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shoe_app/widgets/app_button.dart';

void main() {
  testWidgets('AppButton displays label and responds to tap', (WidgetTester tester) async {
    bool tapped = false;

    // Build AppButton widget.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            label: 'Test Button',
            onTap: () {
              tapped = true;
            },
          ),
        ),
      ),
    );

    // Verify label is displayed.
    expect(find.text('Test Button'), findsOneWidget);

    // Tap button.
    await tester.tap(find.text('Test Button'));
    await tester.pump();

    // Verify tap callback was called.
    expect(tapped, true);
  });
}

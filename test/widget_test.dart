// This is a basic Flutter widget test for the Weather App.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather/main.dart';

void main() {
  testWidgets('Weather app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app title is displayed
    expect(find.text('Weather'), findsOneWidget);

    // Verify that the JSON/XML toggle buttons are present
    expect(find.text('JSON'), findsOneWidget);
    expect(find.text('XML'), findsOneWidget);

    // Verify that the app shows the missing API key message initially
    expect(find.textContaining('Missing API key'), findsOneWidget);
  });

  testWidgets('Weather app format toggle test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Find the toggle buttons
    final jsonButton = find.text('JSON');
    final xmlButton = find.text('XML');

    // Verify both buttons exist
    expect(jsonButton, findsOneWidget);
    expect(xmlButton, findsOneWidget);

    // Verify JSON button is initially selected (default)
    expect(
      tester.widget<ToggleButtons>(find.byType(ToggleButtons)).isSelected,
      [true, false],
    );
  });
}

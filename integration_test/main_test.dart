import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frogger/main.dart';
import 'package:integration_test/integration_test.dart';

// start with
// flutter test integration_test

void main() {
  testWidgets('tap on the floating action button, verify counter',
      (tester) async {
    // Load app widget.
    await tester.pumpWidget(const MyApp());

    // Trigger a frame.
    await tester.pumpAndSettle();
  });
}
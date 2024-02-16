// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frogger/main.dart';


void main() {
  testWidgets('Drawer opens', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());


    // check our title
    expect(find.text('Frogger'), findsOneWidget);
    expect(find.text('This text does not exist'), findsNothing);
    expect(find.text('Login'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byType(IconButton));
    await tester.pump();

    // check if drawer opened
    expect(find.text('Login'), findsOneWidget);
  });
}

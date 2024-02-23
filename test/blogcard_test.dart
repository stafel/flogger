// Test blogcard widget interactions
// We can not use a blog entry directly in the test else it will throw a no directionality widget found error 

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frogger/models/blogentry.dart';
import 'package:frogger/views/blogcard.dart';


void main() {
  testWidgets('Show number of likes one or more', (WidgetTester tester) async {
    var blogEntryOneLike = BlogEntry(id: "test", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: false, totalLikes: 1);

    // Build our app and trigger a frame.
    // Wrap in directionality to prevent no directionality error because of the missing framework
    // Because the like widget consumes an api and a blogentry it will not work
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlogCard(blogEntry: blogEntryOneLike)
      ));

    // total likes should be displayed
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Show no number of likes one zero', (WidgetTester tester) async {
    var blogEntryOneLike = BlogEntry(id: "test", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: false, totalLikes: 0);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlogCard(blogEntry: blogEntryOneLike)
      ));

    // total likes should be displayed
    expect(find.text('0'), findsNothing);
  });

  testWidgets('Show not liked by me heart', (WidgetTester tester) async {
    var blogEntryOneLike = BlogEntry(id: "test", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: false, totalLikes: 0);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlogCard(blogEntry: blogEntryOneLike)
      ));

    // total likes should be displayed
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('Show liked by me heart', (WidgetTester tester) async {
    var blogEntryOneLike = BlogEntry(id: "test", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: true, totalLikes: 0);

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: BlogCard(blogEntry: blogEntryOneLike)
      ));

    // total likes should be displayed
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}

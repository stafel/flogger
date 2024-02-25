// Test blogcard widget interactions
// We can not use a blog entry directly in the test else it will throw a no directionality widget found error 

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frogger/models/author.dart';
import 'package:frogger/models/blog.dart';

import 'package:frogger/models/blogentry.dart';
import 'package:frogger/widgets/blogcard.dart';
import 'package:provider/provider.dart';

// Contains all required widgets for the blog entry to work
class TestScaffold extends StatelessWidget {
  final Widget child;
  final List<BlogEntry> initialEntries;

  TestScaffold({
    super.key,
    required this.child,
    required this.initialEntries
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Blog>(
              create: (_) {
                final myBlog = Blog();
                initialEntries.forEach((element) { myBlog.add(element); });
                return myBlog;
                },
              child: Directionality(
        textDirection: TextDirection.ltr,
        child: child
      ));
  }
}


void main() {
  final testEntryOneLike = BlogEntry(id: "test1", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: false, totalLikes: 1, author: User(id: "null", username: "username"));
  final testEntryZeroLike = BlogEntry(id: "test0", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: false, totalLikes: 0, author: User(id: "null", username: "username"));
  final testEntryLikedByMe = BlogEntry(id: "test0", title: "test", content: "shocking stuff", creationDate: "01.01.2021", liked: true, totalLikes: 1, author: User(id: "null", username: "username"));

  testWidgets('Show number of likes one or more', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrap in directionality to prevent no directionality error because of the missing framework
    // Because the like widget consumes an api and a blogentry it will not work
    await tester.pumpWidget(
      TestScaffold(initialEntries: [testEntryOneLike], child: BlogCard(blogId: testEntryOneLike.id)));

    // total likes should be displayed
    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Show no number of likes one zero', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      TestScaffold(initialEntries: [testEntryZeroLike], child: BlogCard(blogId: testEntryZeroLike.id)));

    // total likes should be displayed
    expect(find.text('0'), findsNothing);
  });

  testWidgets('Show not liked by me heart', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      TestScaffold(initialEntries: [testEntryOneLike], child: BlogCard(blogId: testEntryOneLike.id)));

    // total likes should be displayed
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });

  testWidgets('Show liked by me heart', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      TestScaffold(initialEntries: [testEntryLikedByMe], child: BlogCard(blogId: testEntryLikedByMe.id)));

    // total likes should be displayed
    expect(find.byIcon(Icons.favorite), findsOneWidget);
  });
}
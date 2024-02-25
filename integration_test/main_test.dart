import 'package:convenient_test_dev/convenient_test_dev.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frogger/main.dart';
import 'package:integration_test/integration_test.dart';

// start with
// flutter test integration_test

doDeleteBlog(WidgetTester tester, String title) async {
  expect(find.text(title), findsOne);
  await tester.tap(find.text(title));
  await tester.pumpAndSettle();

  await tester.tap(find.text("Delete this blogpost"));
  await tester.pumpAndSettle();

  expect(find.text(title), findsNothing);
}

doPostBlog(WidgetTester tester, String title, String content) async {
  expect(find.text("Create new blogpost"), findsOneWidget);
  expect(find.text("Save"), findsOneWidget);

  final titleField = find.ancestor(of: find.text("Title"), matching: find.byType(TextFormField));
  final contentField = find.ancestor(of: find.text("Content"), matching: find.byType(TextFormField));

  await tester.pumpAndSettle();
  await tester.enterText(titleField, title);
  await tester.pumpAndSettle();
  await tester.enterText(contentField, content);
  await tester.pumpAndSettle();

  await tester.tap(find.text("Save"));

  await tester.pumpAndSettle();

  expect(find.text(title), findsOne);
}

doLogin(WidgetTester tester) async {
  expect(find.text('Login'), findsOneWidget);

  final usernamefield = find.ancestor(of: find.text("Username"), matching: find.byType(TextFormField));
  final passwordfield = find.ancestor(of: find.text("Password"), matching: find.byType(TextFormField));

  await tester.enterText(usernamefield, "rstest");
  await tester.enterText(passwordfield, "12345rstest");

  await tester.tap(find.text("Login"));

  await tester.pumpAndSettle();
}

doLoginFromMainscreen(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.login));
  await tester.pumpAndSettle();

  await doLogin(tester);
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('login from main screen via login action',
      (tester) async {
    // Load app widget.
    await tester.pumpWidget(const MyApp());

    // Trigger a frame.
    await tester.pumpAndSettle();

    await doLoginFromMainscreen(tester);

  });

  testWidgets("try liking without login, no like change and show login info", (tester) async {
    await tester.pumpWidget(const MyApp());

    // Trigger a frame.
    await tester.pumpAndSettle();

    final firstLike = find.byIcon(Icons.favorite_border).first;

    await tester.tap(firstLike);

    await tester.pumpAndSettle();

    // check if our snackbar login info is shown
    expect(find.text("Login first to like and comment"), findsOneWidget);

    // get the icon button itself to check if the icon was changed
    final dynamic likeButton = tester.widget(firstLike);
    expect(likeButton.icon, Icons.favorite_border);

  });

  testWidgets("try post new blog when logged out", (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    expect(find.text("Create new blogpost"), findsNothing);
  });

  final newBlogTitle = "test ${DateTime.timestamp()}";

  testWidgets("post new blog when logged in", (tester) async {
  
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    await doLoginFromMainscreen(tester);

    await tester.tap(find.text("Create new blogpost"));
    await tester.pumpAndSettle();

    await doPostBlog(tester, newBlogTitle, "this is a test");

    await doDeleteBlog(tester, newBlogTitle);
  });

  testWidgets("delete blog when logged in", (tester) async {
  
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    await doLoginFromMainscreen(tester);

    await doDeleteBlog(tester, newBlogTitle);
  });
}
import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/views/blogcard.dart';
import 'package:frogger/views/blogdetailpage.dart';
import 'package:frogger/views/newblogbutton.dart';
import 'package:frogger/views/logodrawer.dart';
import 'package:frogger/views/customdrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Frogger',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.limeAccent, brightness: Brightness.light),
          useMaterial3: true,
          textTheme: const TextTheme(
              titleLarge: TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
          ))),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.limeAccent, brightness: Brightness.dark),
          useMaterial3: true,
          textTheme: const TextTheme(
              titleLarge: TextStyle(
            fontSize: 40,
            fontStyle: FontStyle.italic,
          ))),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) => BaseView(title: 'Frogger', child: child!),
      navigatorKey: navigatorKey,
      initialRoute: 'homeRoute',
      routes: {
        'homeRoute': (context) => const MyHomePage(),
        'blogdetailRoute': (context) => const BlogDetailPage(),
      },
    );
  }
}

// wrapper to reuse drawer and appbar
class BaseView extends StatelessWidget {
  const BaseView({super.key, required this.child, required this.title});
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          leading: const LogoDrawer(),
        ),
        body: child,
      );
  }
}

class MottoText extends StatelessWidget {
  const MottoText({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Text(AppLocalizations.of(context)!.motto);
  }
}

// displays a list of all blogs
// if loading displays spinner
// if error displays generic message
class BlogList extends StatelessWidget {
  const BlogList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Consumer<Blog>(builder: (ctx, blog, _) {
      if (blog.state == BlogState.loading) {
        return const CircularProgressIndicator();
      }

      if (blog.state == BlogState.error) {
        return Text(AppLocalizations.of(ctx)!.connectionError);
      }

      return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
              itemCount: blog.items.length,
              itemBuilder: (BuildContext context, int index) {
                return BlogCard(blogEntry: blog.items[index]);
              }));
    });
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: ChangeNotifierProvider<Blog>(
              create: (_) => Blog(),
              child: Column(
                 children: [
                    const MottoText(),
                    BlogList(),
                    NewBlogButton(
                        text: "Add new blog",
                        onPressed: () {
                          print("Add entry");
                        }),
                  ],
                ),
          ),
        );
  }
}


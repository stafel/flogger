import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/blogcard.dart';
import 'package:frogger/views/newblogbutton.dart';
import 'package:frogger/views/logodrawer.dart';
import 'package:frogger/views/customdrawer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BlogApi>(
              create: (_) => BlogApi(),
              child:
    MaterialApp(
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
      home: const MyHomePage()
    ));
  }
}

// Display motto
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

// Contains general scaffold data to be reused in pages
class ReusableScaffold extends StatelessWidget {
  final Widget child;
  final bool showIcon;
  final bool showDrawer;

  const ReusableScaffold({super.key, required this.child, this.showIcon=false, this.showDrawer=false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: showDrawer ? const CustomDrawer() : null,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(AppLocalizations.of(context)!.title),
          leading: showIcon ? const LogoDrawer() : null,
          actions: [LoginIconButton()] // TODO: This throws notifier assertion exceptions
        ),
        body: child
    );
  }
}

class MyHomePage extends StatelessWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(showIcon: true, showDrawer: true, child: Center(
          child: Consumer<BlogApi>( builder: (ctx, api, _) { return ChangeNotifierProvider<Blog>(
              create: (_) => Blog(api: api),
              child: Column(
                 children: [
                    const MottoText(),
                    const BlogList(),
                    Consumer<BlogApi>(builder: (ctx, api, _) {
                      if (api.status == BlogApiStatus.conLogin) {
                      return NewBlogButton(
                          text: "Add new blog",
                          onPressed: () {
                            print("Add entry");
                          });
                      }

                      return const SizedBox();
                    }),
                  ],
                ),
          );}
          ),
        )
    );
  }
}


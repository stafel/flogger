import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/views/blogcard.dart';
import 'package:frogger/views/blogdetailpage.dart';
import 'package:frogger/views/newblogbutton.dart';
import 'package:frogger/views/logodrawer.dart';
import 'package:frogger/views/customdrawer.dart';

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

      builder: (context, child) => BaseView(title: 'Frogger', child: child!),
      navigatorKey: navigatorKey,
      initialRoute: 'homeRoute',
      routes: {
        'homeRoute': (context) => const MyHomePage(),
        'blogdetailRoute': (context) => BlogDetailPage(),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState() {
    loadBlogs();
  }

  loadBlogs() async {
    blogList = await BlogApi().fetchBlogs();

    setState(() {
      /* bloglist was updated from api */
    });
  }

  var blogList = [
    BlogEntry(
        id: '1',
        title: "Hello",
        content: "World!",
        creationDate: DateTime.now(),
        liked: true),
    BlogEntry(
        id: '2',
        title: "Top 10 frogs",
        content: "Number 3 will shock you!!1!",
        creationDate: DateTime.now(),
        liked: false)
  ];

  addEntry(BlogEntry newEntry) {
    setState(() {
      blogList.add(newEntry);
    });
  }

  openBlog(String blogId) {
    blogList.where((element) => element.id == blogId).forEach((element) {
      //print(element.uuid);
      //navigatorKey.currentState!.pushNamed(routeName);
      //Navigator.push(context, MaterialPageRoute<void>(builder: (context) => BlogDetailPage()));
      Navigator.pushNamed(context, 'blogdetailRoute');
    });
  }

  likeBlog(String blogId) {
    setState(() {
      blogList.where((element) => element.id == blogId).forEach((element) {
        element.liked = !element.liked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      // the number of items in the list
                      itemCount: blogList.length,

                      // display each item of the product list
                      itemBuilder: (context, index) {
                        var blog = blogList[index];
                        return BlogCard(
                          title: blog.title,
                          content: blog.content,
                          date: blog.creationDate.toString(),
                          liked: blog.liked,
                          onBlogPressed: () {
                            openBlog(blog.id);
                          },
                          onLikePressed: () {
                            likeBlog(blog.id);
                          },
                        );
                      })),
              NewBlogButton(
                  text: "Add new blog",
                  onPressed: () {
                    addEntry(BlogEntry(
                        id: '3',
                        title: "test",
                        content: "wow",
                        creationDate: DateTime.now(),
                        liked: false));
                  }),
            ],
          ),
        );
  }
}


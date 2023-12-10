import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/views/blogcard.dart';
import 'package:frogger/views/newblogbutton.dart';
import 'package:frogger/views/logodrawer.dart';
import 'package:frogger/views/customdrawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(title: 'Frogger'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var blogList = [
    BlogEntry(
        title: "Hello",
        content: "World!",
        creationDate: DateTime.now(),
        liked: true),
    BlogEntry(
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
    blogList.where((element) => element.uuid == blogId).forEach((element) {
      //print(element.uuid);
    });
  }

  likeBlog(String blogId) {
    setState(() {
      blogList.where((element) => element.uuid == blogId).forEach((element) {
        element.liked = !element.liked;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          leading: const LogoDrawer(),
        ),
        body: Center(
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
                            openBlog(blog.uuid);
                          },
                          onLikePressed: () {
                            likeBlog(blog.uuid);
                          },
                        );
                      })),
              NewBlogButton(
                  text: "Add new blog",
                  onPressed: () {
                    addEntry(BlogEntry(
                        title: "test",
                        content: "wow",
                        creationDate: DateTime.now(),
                        liked: false));
                  }),
            ],
          ),
        ));
  }
}


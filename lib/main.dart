import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/views/blogcard.dart';
import 'package:frogger/views/newblogbutton.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent),
        useMaterial3: true,
      ),
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
    blogList.where((element) => element.uuid == blogId).forEach((element) { print(element.uuid); });
  }

  likeBlog(String blogId) {
    setState(() {
      blogList.where((element) => element.uuid == blogId).forEach((element) { element.liked = !element.liked; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          leading: Image.asset("images/logo.png"),
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
                            onBlogPressed: (){ openBlog(blog.uuid); },
                            onLikePressed: (){ likeBlog(blog.uuid); },);
                      })),
                      NewBlogButton(text: "Add new blog", onPressed: () {
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

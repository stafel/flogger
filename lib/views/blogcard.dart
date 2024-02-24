import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/views/authorinfo.dart';
import 'package:frogger/views/blogdetailpage.dart';
import 'package:frogger/views/like.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class BlogCard extends StatelessWidget {
  final BlogEntry blogEntry;

  const BlogCard(
      {super.key,
      required this.blogEntry});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<BlogEntry>(
              create: (_) => blogEntry,
              child: Card(
      child: InkWell(
        onTap: () { 
          Logger().d("tapped ${blogEntry.id}");
          Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(entry: blogEntry)));
        },
        child: Column(
        children: [
          ListTile(
            title: Text(blogEntry.title),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ListBody(
              children: [
                Text(blogEntry.content),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Authorinfo(), 
                    Like()
                  ],
                )
              ],
            ),
          )
        ],
      ),
      ),
    ));
  }
}

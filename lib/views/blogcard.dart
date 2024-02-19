import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/views/blogdetailpage.dart';
import 'package:frogger/views/like.dart';

class BlogCard extends StatelessWidget {
  final BlogEntry blogEntry;

  const BlogCard(
      {super.key,
      required this.blogEntry});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () { 
          print("tapped ${blogEntry.id}");
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(blogEntry.creationDate.toString()), Like(liked: blogEntry.liked, onLikePressed: () { print("liked ${blogEntry.id}"); },)],
                )
              ],
            ),
          )
        ],
      ),
      ),
    );
  }
}

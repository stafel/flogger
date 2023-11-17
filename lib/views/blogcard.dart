import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  final bool liked;

  const BlogCard(
      {super.key,
      required this.title,
      required this.content,
      required this.date,
      required this.liked});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(title),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ListBody(
              children: [
                Text(content),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date),
                    Icon(liked ? Icons.favorite : Icons.favorite_border)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

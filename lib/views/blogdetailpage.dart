import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:frogger/models/blogentry.dart';

class BlogDetailPage extends StatelessWidget {
  final BlogEntry entry;

  const BlogDetailPage({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return ReusableScaffold(showIcon: false, child: Center(
      child: Column(
        children: [
          Row( children: [const Text("Title"), Text(entry.title)]),
          Row( children: [const Text("Body"), Text(entry.content)]),
        ]
      )
    )
    );
  }

}
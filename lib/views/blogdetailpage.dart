import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {

  const BlogDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Row( children: [Text("Title")]),
          Row( children: [Text("Body")]),
        ]
      )
    );
  }

}
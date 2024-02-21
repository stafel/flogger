import 'package:flutter/material.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:provider/provider.dart';

class Like extends StatelessWidget {
  const Like({
    super.key,
    required this.liked,
    required this.blogId
  });

  final String blogId;

  final bool liked;

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogApi>(builder: (ctx, api, _) {
      return IconButton(
        onPressed: () { 
          if (liked) {
            api.unlikeBlog(blogId);
          } else {
            api.likeBlog(blogId);
          }
        },
        icon: Icon(liked ? Icons.favorite : Icons.favorite_border));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:provider/provider.dart';

class Like extends StatelessWidget {
  const Like({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogEntry>(builder: (ctx, entry, _) {
      return Row(
        children: [
          entry.totalLikes > 0 ? Text(entry.totalLikes.toString()) : const Text(" "),
          IconButton(
            onPressed: () { 
              if (entry.liked) {
                entry.unlike();
              } else {
                entry.like();
              }
            },
            icon: Icon(entry.liked ? Icons.favorite : Icons.favorite_border))
        ]);
    });
  }
}

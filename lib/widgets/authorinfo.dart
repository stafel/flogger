import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:provider/provider.dart';

class Authorinfo extends StatelessWidget {
  final String blogId;

  const Authorinfo({
    super.key,
    required this.blogId
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Blog>(builder: (ctx, blog, _) {

      final blogEntry = blog.getById(blogId)!;
      return Align(
        alignment: Alignment.topLeft,
        child: Text("by ${blogEntry.author.username} on ${blogEntry.creationDate}"),
      );
    });
  }
}

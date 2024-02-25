import 'package:flutter/material.dart';
import 'package:frogger/main.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/services/blogapi.dart';
import 'package:frogger/widgets/authorinfo.dart';
import 'package:frogger/widgets/like.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlogDetailPage extends StatelessWidget {
  final String blogId;

  const BlogDetailPage({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return Consumer<Blog>(builder: (ctx, blog, _) {

      final maybeBlogEntry = blog.getById(blogId);

      // show an error if we found no blog with this id
      if (maybeBlogEntry == null) {
        return Text(AppLocalizations.of(context)!.error);
      }

      final BlogEntry blogEntry = maybeBlogEntry; 


      return ReusableScaffold(title: blogEntry.title, showIcon: false, child: Center(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Authorinfo(blogId: blogId), Like(blogId: blogId)]), // creates problem with notification dispose
            Row( children: [const Text("Body"), Text(blogEntry.content)]),
            Consumer<BlogApi>(builder: (ctx, api, _) {
              if (api.status == BlogApiStatus.conLogin) {
                return Text("Edit");
              }

              return const SizedBox();
            }),
          ]
        )
      ));
    }
    );
    }
  }
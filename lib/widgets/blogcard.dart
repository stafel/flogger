import 'package:flutter/material.dart';
import 'package:frogger/models/blog.dart';
import 'package:frogger/models/blogentry.dart';
import 'package:frogger/widgets/authorinfo.dart';
import 'package:frogger/routes/blogdetailpage.dart';
import 'package:frogger/widgets/like.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlogCard extends StatelessWidget {
  final String blogId;

  const BlogCard(
      {super.key,
      required this.blogId});

  @override
  Widget build(BuildContext context) {

    return Consumer<Blog>(builder: (ctx, blog, _) {

      final maybeBlogEntry = blog.getById(blogId);

      // show an error if we found no blog with this id
      if (maybeBlogEntry == null) {
        return Text(AppLocalizations.of(context)!.error);
      }

      final BlogEntry blogEntry = maybeBlogEntry; 

      return Card(
      child: InkWell(
        onTap: () { 
          Logger().d("tapped ${blogEntry.id}");
          Navigator.push(context, MaterialPageRoute(builder: (context) => BlogDetailPage(blogId: blogId)));
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
                  children: [
                    Authorinfo(blogId: blogId), 
                    Like(blogId: blogId)
                  ],
                )
              ],
            ),
          )
        ],
      ),
      ),
    );
    }
    );
  }
}
